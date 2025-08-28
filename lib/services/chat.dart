import 'dart:async';
import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:ollama_dart/ollama_dart.dart' as ollama;
import 'package:uuid/uuid.dart';

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import 'clients.dart' as clients;
import 'haptic.dart';
import 'model.dart';
import 'preferences.dart';

enum MessageSender { user, assistant }

class Message extends ChangeNotifier {
  final String id;

  final MessageSender sender;
  final DateTime createdAt;

  Message({required this.sender, DateTime? createdAt})
    : id = const Uuid().v4(),
      createdAt = createdAt ?? DateTime.now();

  void modify() => notifyListeners();

  Map<String, dynamic> toJson() =>
      throw UnimplementedError("toJson() must be implemented in subclasses");

  @override
  String toString() => toJson().toString();

  @override
  operator ==(Object other) {
    return other is Message && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class TextMessage extends Message {
  bool _locked = false;

  String _content;
  String get content => _content;

  bool _includesError = false;
  bool get includesError => _includesError;

  TextMessage(String content, {required super.sender, super.createdAt})
    : _content = content;

  @override
  void modify({String? content}) {
    if (_locked) throw StateError("Cannot modify a locked message.");
    if (content != null) _content = content;
    super.modify();
  }

  @override
  Map<String, dynamic> toJson() => {
    "type": "text",
    "role": sender.name,
    "content": content,
    "includesError": includesError,
    "createdAt": createdAt.toUtc().millisecondsSinceEpoch,
  };

  factory TextMessage.fromStream(
    Stream<ollama.GenerateChatCompletionResponse> stream, {
    required MessageSender sender,
    Completer<void>? completer,
    void Function(String content)? onContent,
  }) {
    return TextMessage("", sender: sender, createdAt: DateTime.now())
      .._contentFromStream(stream, completer: completer, onContent: onContent);
  }

  Future<void> _contentFromStream(
    Stream<ollama.GenerateChatCompletionResponse> stream, {
    Completer<void>? completer,
    void Function(String content)? onContent,
  }) async {
    assert(!_locked, "Cannot modify a locked message.");
    _locked = true;

    try {
      await for (var response in stream) {
        if (completer?.isCompleted ?? false) return;
        _content += response.message.content;
        chatHaptic();

        notifyListeners();
        onContent?.call(_content);
      }
    } catch (e, s) {
      if (completer?.isCompleted ?? false) return;
      completer?.completeError(e, s);
    }
    if (completer?.isCompleted ?? false) return;
    _content = _content.trim();

    Future.delayed(const Duration(milliseconds: 250), heavyHaptic);
    completer?.complete();
    _locked = false;
  }
}

class ImageMessage extends Message {
  final Uri image;
  final String? name;

  ImageMessage({
    required this.image,
    this.name,
    required super.sender,
    super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    "type": "image",
    "role": sender.name,
    "image": image.toString(),
    "name": name,
    "createdAt": createdAt.toUtc().millisecondsSinceEpoch,
  };
}

class Chat extends ChangeNotifier {
  Completer<void>? completer;

  bool get alive => ChatManager.instance.chats.contains(this);
  bool get active => alive && ChatManager.instance.currentChatId == id;

  final String id;
  final DateTime createdAt;

  String? _modelName;
  String? get modelName => _modelName;
  set modelName(String? name) {
    assert(alive, "Chat must be alive to be modified.");

    _modelName = name;
    if (ChatManager.instance.currentChatId == id) {
      ModelManager.instance.currentModelName = name;
    }
    notifyListeners();
  }

  Model? get model => ModelManager.instance.models.firstOrNullWhere(
    (m) => m.name == _modelName,
  );
  set model(Model? model) => modelName = model?.name;

  String _title;
  String get title => _title;
  set title(String title) {
    assert(alive, "Chat must be alive to be modified.");

    _title = title;
    notifyListeners();
  }

  final Set<Message> _messages;
  Set<Message> get messages => Set.unmodifiable(_messages);

  final String? system;

  Chat._({
    required String? modelName,
    required String title,
    required this.createdAt,
    Set<Message>? messages,
    String? system,
  }) : id = const Uuid().v4(),
       _modelName = modelName,
       _title = title,
       _messages = messages ?? {},
       system = system ?? Preferences.instance.system {
    addListener(ChatManager.instance.notifyListeners);
    for (var m in _messages) {
      m.addListener(notifyListeners);
    }
  }

  List<ollama.Message> toApi() {
    var messages = <ollama.Message>[];
    var images = <ImageMessage>[];

    var systemMessage = system;
    if (systemMessage != null) {
      messages.add(
        ollama.Message(role: ollama.MessageRole.system, content: systemMessage),
      );
    }

    for (var message in _messages) {
      switch (message) {
        case TextMessage message:
          messages.add(
            ollama.Message(
              role: message.sender == MessageSender.user
                  ? ollama.MessageRole.user
                  : ollama.MessageRole.assistant,
              content: message.content,
              images: images.map((e) => e.image.toString()).toList(),
            ),
          );
          images.clear();
        case ImageMessage message:
          images.add(message);
      }
    }

    return messages;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "model": model?.name,
    "createdAt": createdAt.toUtc().millisecondsSinceEpoch,
    "title": title,
    "messages": _messages.map((e) => e.toJson()).toList(),
    "system": system,
  };

  Future<void> generateTitle({
    required BuildContext context,
    bool? think = false,
  }) async {
    assert(alive, "Chat must be alive to be modified.");
    assert(model != null, "Chat model must be set to generate a title.");

    if (_messages.isEmpty ||
        model == null ||
        !Preferences.instance.generateTitles) {
      _title = AppLocalizations.of(mainContext!).newChatTitle;
      return;
    }

    var effectiveThink =
        (think ?? false) &&
        model!.capabilities.contains(ModelCapability.thinking);

    var content = jsonEncode(
      (toJson()["messages"] as List<Map<String, dynamic>>)
          .map(
            (e) => e
              ..removeWhere(
                (k, _) => !["type", "role", "content", "name"].contains(k),
              ),
          )
          .toList(),
    );
    var request = ollama.GenerateChatCompletionRequest(
      model: modelName!,
      messages: [
        const ollama.Message(
          role: ollama.MessageRole.system,
          content:
              "Generate a two to five word title for the conversation provided by the user. "
              "If an object or person is very important in the conversation, put it in the title as well; keep the focus on the main subject. Also make an assumption about things happening in the conversation following the messages provided. "
              "You must not put the assistant in the focus and you must not put the word 'assistant' in the title! "
              "Use a factual, formal tone; don't make the title dramatic using dramatic words. Preferably use nouns and adjectives, not verbs. Also avoid using words like 'simple' or 'easy' to not belittle the user or their problem. "
              "Do preferably use title case. You must not use markdown or any other formatting language! You must not use emojis or any other symbols! You must not use general clauses like 'assistance', 'help' or 'session' in your title!\n\n"
              "Example bad titles compared to good titles:\n\n~~User Introduces Themselves~~ -> User Introduction\n~~User Asks for Help with a Problem~~ -> Problem Help\n~~User has a _**big**_ Problem~~ -> Big Problem",
        ),
        ollama.Message(
          role: ollama.MessageRole.user,
          content: "```json\n$content\n```",
        ),
      ],
      keepAlive: Preferences.instance.keepAlive,
      think: effectiveThink,
    );

    ollama.GenerateChatCompletionResponse generated;
    try {
      generated = await clients.ollamaClient
          .generateChatCompletion(request: request)
          .timeout(TimeoutMultiplier.long);
    } catch (e, s) {
      if (alive) Error.throwWithStackTrace(e, s);
      return;
    }
    var newTitle = generated.message.content;
    newTitle = newTitle.replaceAll("\n", " ");

    for (var term in [
      '"',
      "'",
      "*",
      "_",
      ".",
      ",",
      "!",
      "?",
      ":",
      ";",
      "(",
      ")",
      "[",
      "]",
      "{",
      "}",
      "<",
      ">",
    ]) {
      newTitle = newTitle.replaceAll(term, "");
    }

    while (newTitle.contains(" " * 2)) {
      newTitle = newTitle.replaceAll(" " * 2, " " * 1);
    }

    title = newTitle.trim();
  }

  Future<void> send(
    Message message, {
    bool awaitCompletion = true,
    bool? think,
    void Function(String)? onContent,
  }) async {
    assert(alive, "Chat must be alive to be modified.");

    assert(model != null, "Chat model must be set to send messages.");
    if (model == null) return;

    _messages.add(message..addListener(notifyListeners));

    var finalThink =
        (think ?? Preferences.instance.thinking) &&
        model!.capabilities.contains(ModelCapability.thinking);

    if (message is TextMessage && message.sender == MessageSender.user) {
      completer = Completer<void>();
      var message = TextMessage.fromStream(
        clients.ollamaClient.generateChatCompletionStream(
          request: ollama.GenerateChatCompletionRequest(
            model: model!.name,
            messages: toApi(),
            stream: true,
            keepAlive: Preferences.instance.keepAlive,
            think: finalThink,
          ),
        ),
        sender: MessageSender.assistant,
        completer: completer,
        onContent: onContent,
      )..addListener(notifyListeners);
      _messages.add(message);

      var future = completer!.future
          .then((_) => ChatManager.instance.saveChats())
          .catchError((e, s) {
            message
              .._includesError = true
              ..modify();
            Error.throwWithStackTrace(e, s);
          });
      if (awaitCompletion) await future;
    }

    notifyListeners();
    await ChatManager.instance.saveChats();
  }

  void deleteMessage(Message message) {
    assert(alive, "Chat must be alive to be modified.");

    _messages.remove(message);
    message.removeListener(notifyListeners);
    notifyListeners();
  }
}

class ChatManager extends ChangeNotifier {
  static final ChatManager _instance = ChatManager._();
  static ChatManager get instance => _instance;

  String? _currentChatId;
  String? get currentChatId => _currentChatId;
  set currentChatId(String? id) {
    _currentChatId = id;
    if (id != null) {
      ModelManager.instance.currentModelName = _chats
          .singleWhere((e) => e.id == id)
          .model!
          .name;
    }
    notifyListeners();
  }

  Chat? get currentChat => _currentChatId == null
      ? null
      : _chats.singleWhere((e) => e.id == _currentChatId);
  set currentChat(Chat? chat) => currentChatId = chat?.id;

  final Set<Chat> _chats = {};
  Set<Chat> get chats => Set.unmodifiable(_chats);

  ChatManager._();

  Future<void> loadChats() async {
    DateTime getDateTimeFromMilliseconds(int? milliseconds) {
      if (milliseconds == null) return DateTime.now();
      return DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
    }

    var stored = prefs!.getStringList("chats") ?? [];
    _chats.clear();
    for (var chatJson in stored) {
      try {
        var chatData = jsonDecode(chatJson);

        var messages = <Message>{};
        String? system;
        for (var message in chatData["messages"]) {
          if (message["role"] == "system") {
            system = message["content"];
          }

          switch (message["type"]) {
            case "text":
              messages.add(
                TextMessage(
                  message["content"],
                  sender: MessageSender.values.byName(message["role"]),
                  createdAt: getDateTimeFromMilliseconds(message["createdAt"]),
                ),
              );
            case "image":
              messages.add(
                ImageMessage(
                  image: Uri.parse(message["image"]),
                  name: message["name"],
                  sender: MessageSender.values.byName(message["role"]),
                  createdAt: getDateTimeFromMilliseconds(message["createdAt"]),
                ),
              );
          }
        }

        _chats.add(
          Chat._(
            modelName: chatData["model"],
            createdAt: getDateTimeFromMilliseconds(chatData["createdAt"]),
            title: chatData["title"],
            messages: messages,
            system: system,
          ),
        );
      } catch (_) {
        rethrow;
      }
    }
    notifyListeners();
  }

  Future<void> saveChats() async {
    prefs!.setStringList(
      "chats",
      _chats.map((c) => jsonEncode(c.toJson())).toList(),
    );
  }

  Chat createChat({
    required BuildContext? context,
    required Model? model,
    String? title,
    String? system,
  }) {
    assert(
      allowMultipleChats || chats.isEmpty,
      "Cannot create a new chat when multiple chats are not allowed and there is already a chat.",
    );

    var chat = Chat._(
      modelName: model?.name,
      createdAt: DateTime.now(),
      title:
          title ??
          ((context != null)
              ? AppLocalizations.of(context).newChatTitle
              : "Unnamed Chat"),
      system: system ?? Preferences.instance.system,
    );
    _chats.add(chat);
    _currentChatId = chat.id;

    notifyListeners();
    saveChats();

    return chat;
  }

  void deleteChat(Chat chat) {
    _chats.remove(chat);
    if (chat.completer?.isCompleted == false) chat.completer!.complete();
    chat.removeListener(notifyListeners);

    if (_currentChatId == chat.id) _currentChatId = null;

    notifyListeners();
    saveChats();
  }
}

// MARK: Delete Chat Dialog

Future<bool> showDeleteChatDialog(
  BuildContext context, {
  Chat? chat,
  FutureOr<void> Function()? onDelete,
}) {
  chat ??= ChatManager.instance.currentChat;
  var completer = Completer<bool>();
  if (Preferences.instance.askBeforeDeletion) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteChatDialog(
          chat: chat!,
          onDelete: onDelete,
          completer: completer,
        );
      },
    );
  } else {
    ChatManager.instance.deleteChat(chat!);
  }
  return completer.future;
}

class DeleteChatDialog extends StatelessWidget {
  final Chat chat;
  final FutureOr<void> Function()? onDelete;
  final Completer<bool> completer;

  const DeleteChatDialog({
    super.key,
    required this.chat,
    required this.onDelete,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        if (!completer.isCompleted) completer.complete(false);
      },
      child: AlertDialog(
        title: Text(AppLocalizations.of(context).deleteDialogTitle),
        content: Text(AppLocalizations.of(context).deleteDialogDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).deleteDialogCancel),
          ),
          TextButton(
            onPressed: () {
              ChatManager.instance.deleteChat(chat);
              completer.complete(true);
              onDelete?.call();
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).deleteDialogDelete),
          ),
        ],
      ),
    );
  }
}

// MARK: Chat Text Widget

class ChatText extends StatefulWidget {
  final String content;
  final Duration? flyInDuration;
  final Widget? placeholder;

  const ChatText(
    this.content, {
    super.key,
    this.flyInDuration,
    this.placeholder,
  });

  @override
  State<ChatText> createState() => _ChatTextState();
}

class _ChatTextState extends State<ChatText> with TickerProviderStateMixin {
  late List<String> _words;
  late final List<AnimationController?> _controllers;

  @override
  void initState() {
    super.initState();
    _words = _splitWords(widget.content);
    _controllers = List.generate(_words.length, (_) => null);
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c?.dispose();
    }
    super.dispose();
  }

  List<String> _splitWords(String s) {
    if (s.trim().isEmpty) return <String>[];
    return s.split(RegExp(r"(?=\s+)"));
  }

  @override
  Widget build(BuildContext context) {
    var newWords = _splitWords(
      widget.content.replaceFirst(
        RegExp("^${RegExp.escape(_words.join())}"),
        "",
      ),
    );

    for (var word in newWords.asMap().entries) {
      _words.add(word.value);
      _controllers.add(
        AnimationController(
            value: 0,
            vsync: this,
            duration: widget.flyInDuration ?? Durations.medium1,
          )
          ..addListener(() {
            var index = word.key + _words.length - newWords.length;
            if (_controllers[index]?.value == 1) {
              _controllers[index]!.dispose();
              _controllers[index] = null;
            }

            setState(() {});
          })
          ..forward(),
      );
    }

    var finalColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
    return (_words.isEmpty && widget.placeholder != null)
        ? widget.placeholder!
        : AnimatedSize(
            alignment: Alignment.topLeft,
            duration: Durations.short2,
            child: Text.rich(
              TextSpan(
                children: _words
                    .asMap()
                    .entries
                    .map(
                      (e) => TextSpan(
                        text: e.value,
                        style: TextStyle(
                          color: finalColor.withValues(
                            alpha: _controllers[e.key]?.value,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}
