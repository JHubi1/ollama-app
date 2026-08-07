import 'dart:async';
import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'package:ollama_dart/ollama_dart.dart' as llama;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import 'chat_database/chat_database.dart';
import 'clients.dart' as clients;
import 'haptic.dart';
import 'model.dart';
import 'preferences.dart';

enum MessageSender { user, assistant }

abstract class Message extends ChangeNotifier {
  final String id;

  final MessageSender sender;
  final DateTime createdAt;

  Message({required this.sender, DateTime? createdAt})
    : id = const Uuid().v4(),
      createdAt = createdAt ?? DateTime.now();

  void modify() => notifyListeners();

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();

  @override
  operator ==(Object other) => other is Message && other.id == id;
  @override
  int get hashCode => id.hashCode;

  static Message Function(Map<String, dynamic> json)? constructorForType(
    String type,
  ) => switch (type) {
    "text" => TextMessage.fromJson,
    "image" => ImageMessage.fromJson,
    _ => null,
  };
}

class TextMessage extends Message {
  bool _locked = false;

  String _content;
  String get content => _content;

  String? _thinking;
  String? get thinking => _thinking;

  ChatUsageStats? _stats;
  ChatUsageStats? get stats => _stats;

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
    "thinking": thinking,
    "stats": stats?.toJson(),
    "includesError": includesError,
    "createdAt": createdAt.toUtc().millisecondsSinceEpoch,
  };

  TextMessage.fromJson(Map<String, dynamic> json)
    : _content = json["content"],
      _thinking = json["thinking"],
      _stats = json["stats"] != null
          ? ChatUsageStats.fromJson(json["stats"])
          : null,
      _includesError = json["includesError"] ?? false,
      super(
        sender: MessageSender.values.byName(json["role"]),
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          json["createdAt"],
          isUtc: true,
        ),
      );

  factory TextMessage.fromStream(
    Stream<llama.ChatStreamEvent> stream, {
    required MessageSender sender,
    Completer<void>? completer,
    void Function(String content)? onContent,
    Future<void> Function()? saveChat,
  }) => TextMessage("", sender: sender, createdAt: DateTime.now())
    .._contentFromStream(
      stream,
      completer: completer,
      onContent: onContent,
      saveChat: saveChat,
    );

  Future<void> _contentFromStream(
    Stream<llama.ChatStreamEvent> stream, {
    Completer<void>? completer,
    void Function(String content)? onContent,
    Future<void> Function()? saveChat,
  }) async {
    assert(!_locked, "Cannot modify a locked message.");
    if (_locked) return;
    _locked = true;

    try {
      StreamSubscription? sub;
      sub = stream.listen((event) {
        if (completer?.isCompleted ?? false) {
          sub?.cancel();
          return;
        }

        if (event.message?.thinking != null) {
          _thinking = "${_thinking ?? ""}${event.message?.thinking}";
        }
        if (event.done ?? false) {
          _stats = ChatUsageStats.fromChatResponse(event);
        }

        _content += event.message!.content!;
        chatHaptic();

        notifyListeners();
        onContent?.call(_content);
        saveChat?.call();
      });
      await sub.asFuture();
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
  Uri _image;
  Uri get image => _image;

  final String? name;

  double? _aspectRatio;
  double? get aspectRatio => _aspectRatio;

  int? _width;
  int? get width => _width;

  ImageMessage({
    required this._image,
    this.name,
    this._aspectRatio,
    this._width,
    required super.sender,
    super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    "type": "image",
    "role": sender.name,
    "image": image.toString(),
    "name": name,
    "aspectRatio": aspectRatio,
    "width": width,
    "createdAt": createdAt.toUtc().millisecondsSinceEpoch,
  };

  ImageMessage.fromJson(Map<String, dynamic> json)
    : _image = json["image"] != null
          ? Uri.parse(json["image"])
          : Uri.parse(
              "data:${lookupMimeType(json["name"])};base64,${json["content"]}",
            ),
      name = json["name"],
      _aspectRatio = (json["aspectRatio"] as num?)?.toDouble(),
      _width = json["width"],
      super(
        sender: MessageSender.values.byName(json["role"]),
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          json["createdAt"],
          isUtc: true,
        ),
      );

  Future<void> computeImageMeta() async {
    try {
      final data = image.scheme == "ref"
          ? await (chatDb.select(chatDb.assets)
                  ..where((a) => a.id.equals(image.authority)))
                .getSingleOrNull()
                .then((r) => r?.data)
          : base64Decode(image.toString().split(",").last);
      if (data == null) return;

      final decodedImage = img.decodeImage(data);
      if (decodedImage == null) return;

      _aspectRatio = decodedImage.width / decodedImage.height;
      _width = decodedImage.width;
    } catch (_) {}
  }

  Future<ImageProvider> get imageProvider async {
    assert(
      image.scheme == "ref",
      "Only images with a 'ref' scheme should be used; please await for migration before using images.",
    );

    if (image.scheme == "ref") {
      final img = await (chatDb.select(
        chatDb.assets,
      )..where((img) => img.id.equals(image.authority))).getSingleOrNull();
      if (img != null) return MemoryImage(img.data);
    } else if (image.scheme == "data") {
      return MemoryImage(base64Decode(image.toString().split(",").last));
    }
    return NetworkImage(image.toString());
  }
}

class ChatUsageStats {
  final Duration totalDuration;
  final Duration? loadDuration;
  final int promptEvalCount;
  final Duration? promptEvalDuration;
  final int evalCount;
  final Duration? evalDuration;

  ChatUsageStats._({
    required this.totalDuration,
    required this.loadDuration,
    required this.promptEvalCount,
    required this.promptEvalDuration,
    required this.evalCount,
    required this.evalDuration,
  });

  static ChatUsageStats? fromChatResponse(llama.ChatStreamEvent response) {
    if (response.totalDuration == null ||
        response.promptEvalCount == null ||
        response.evalCount == null) {
      return null;
    }

    return ChatUsageStats._(
      totalDuration: Duration(microseconds: response.totalDuration! ~/ 1000),
      loadDuration: response.loadDuration != null
          ? Duration(microseconds: response.loadDuration! ~/ 1000)
          : null,
      promptEvalCount: response.promptEvalCount!,
      promptEvalDuration: response.promptEvalDuration != null
          ? Duration(microseconds: response.promptEvalDuration! ~/ 1000)
          : null,
      evalCount: response.evalCount!,
      evalDuration: response.evalDuration != null
          ? Duration(microseconds: response.evalDuration! ~/ 1000)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "totalDuration": totalDuration.inMicroseconds,
    "loadDuration": loadDuration?.inMicroseconds,
    "promptEvalCount": promptEvalCount,
    "promptEvalDuration": promptEvalDuration?.inMicroseconds,
    "evalCount": evalCount,
    "evalDuration": evalDuration?.inMicroseconds,
  };

  factory ChatUsageStats.fromJson(Map<String, dynamic> json) =>
      ChatUsageStats._(
        totalDuration: Duration(microseconds: json["totalDuration"]),
        loadDuration: json["loadDuration"] != null
            ? Duration(microseconds: json["loadDuration"])
            : null,
        promptEvalCount: json["promptEvalCount"],
        promptEvalDuration: json["loadDuration"] != null
            ? Duration(microseconds: json["promptEvalDuration"])
            : null,
        evalCount: json["evalCount"],
        evalDuration: json["loadDuration"] != null
            ? Duration(microseconds: json["evalDuration"])
            : null,
      );
}

class Chat extends ChangeNotifier {
  Completer<void> completer = Completer<void>()..complete();

  bool get alive => ChatManager.instance.chats.contains(this);
  bool get active => alive && ChatManager.instance.currentChatId == id;

  final String id;
  final DateTime createdAt;

  String? _modelName;
  String? get modelName => _modelName;
  set modelName(String? name) {
    assert(alive, "Chat must be alive to be modified.");
    if (!alive) return;

    _modelName = name;
    if (ChatManager.instance.currentChatId == id) {
      ModelManager.instance.currentModelName = name;
    }
    notifyListeners();
    saveChat();
  }

  Model? get model => ModelManager.instance.models.firstOrNullWhere(
    (m) => m.name == _modelName,
  );
  set model(Model? model) => modelName = model?.name;

  String _title;
  String get title => _title;
  set title(String title) {
    assert(alive, "Chat must be alive to be modified.");
    if (!alive) return;

    _title = title;
    notifyListeners();
    saveChat();
  }

  final List<Message> _messages;
  List<Message> get messages => List.unmodifiable(_messages);

  final String? system;

  Chat._({
    String? id,
    required String? modelName,
    required this._title,
    required this.createdAt,
    List<Message>? messages,
    String? system,
  }) : id = id ?? const Uuid().v4(),
       _modelName = modelName ?? ModelManager.instance.currentModelName,
       _messages = messages ?? [],
       system = system ?? Preferences.instance.system {
    addListener(ChatManager.instance.notifyListeners);
    for (var m in _messages) {
      m.addListener(notifyListeners);
    }
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.removeListener(notifyListeners);
    }
    if (completer.isCompleted == false) completer.complete();
    if (ChatManager.instance.currentChatId == id) {
      ChatManager.instance.currentChatId = null;
    }
    super.dispose();
  }

  List<llama.ChatMessage> toApi() {
    final messages = <llama.ChatMessage>[];
    final images = <ImageMessage>[];

    final systemMessage = system;
    if (systemMessage != null) {
      messages.add(
        llama.ChatMessage(
          role: llama.MessageRole.system,
          content: systemMessage,
        ),
      );
    }

    for (var message in _messages) {
      switch (message) {
        case final TextMessage message:
          messages.add(
            llama.ChatMessage(
              role: message.sender == MessageSender.user
                  ? llama.MessageRole.user
                  : llama.MessageRole.assistant,
              content: message.content,
              images: images.map((e) => e.image.toString()).toList(),
            ),
          );
          images.clear();
        case final ImageMessage message
            when message.sender == MessageSender.user:
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
    if (!alive || model == null) return;

    if (_messages.isEmpty ||
        model == null ||
        !Preferences.instance.generateTitles) {
      _title = AppLocalizations.of(context).newChatTitle;
      return;
    }

    final effectiveThink =
        (think ?? false) &&
        model!.capabilities.contains(ModelCapability.thinking);

    final content = jsonEncode(
      (toJson()["messages"] as List<Map<String, dynamic>>)
          .map(
            (e) => e
              ..removeWhere(
                (k, _) => !["type", "role", "content", "name"].contains(k),
              ),
          )
          .toList(),
    );
    final request = llama.ChatRequest(
      model: modelName!,
      messages: [
        const llama.ChatMessage(
          role: llama.MessageRole.system,
          content:
              "Generate a two to five word title for the conversation provided by the user. "
              "Focus on the main subject or topic. If a specific object, person, or concept is central to the discussion, include it in the title. "
              "Do not focus on the assistant; never use the word 'assistant' or imply it is the subject. "
              "Use a factual, neutral tone. Prefer nouns and adjectives over verbs. Do not use dramatic, vague, or belittling words such as 'simple', 'easy', 'big', or 'interesting'. "
              "Use title case. Do not use markdown, emojis, symbols, or generic terms like 'assistance', 'help', 'session', or 'conversation'.\n\n"
              "---\n\nExamples (bad -> good):\n\n~~User Introduces Themselves~~ -> User Introduction\n~~User Asks for Help with a Problem~~ -> Problem Troubleshooting\n~~User has a _**big**_ Problem~~ -> Issue Diagnosis\n~~Simple Python Question~~ -> Python Syntax Help",
        ),
        llama.ChatMessage(
          role: llama.MessageRole.user,
          content: "```json\n$content\n```",
        ),
      ],
      keepAlive: llama.KeepAlive.number(Preferences.instance.keepAlive),
      think: llama.ThinkValue.enabled(effectiveThink),
    );

    llama.ChatResponse generated;
    try {
      generated = await clients.ollamaClient.chat
          .create(request: request)
          .timeout(TimeoutMultiplier.long);
    } catch (e, s) {
      if (alive) Error.throwWithStackTrace(e, s);
      return;
    }
    if (!alive) return;

    var newTitle = generated.message!.content!;
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

  void append(Message message) {
    assert(alive, "Chat must be alive to be modified.");
    if (!alive) return;

    _messages.add(message..addListener(notifyListeners));
    notifyListeners();
    saveChat();
  }

  Future<void> send(
    Message message, {
    bool awaitCompletion = true,
    bool? think,
    void Function(String content)? onContent,
  }) async {
    assert(alive, "Chat must be alive to be modified.");
    if (!alive) return;

    assert(model != null, "Chat model must be set to send messages.");
    if (model == null) return;

    assert(
      completer.isCompleted,
      "Cannot send a message while another message is being sent.",
    );
    if (!completer.isCompleted) return;

    _messages.add(message..addListener(notifyListeners));

    final finalThink =
        (think ?? Preferences.instance.thinking) &&
        model!.capabilities.contains(ModelCapability.thinking);

    if (message is TextMessage && message.sender == MessageSender.user) {
      completer = Completer<void>();
      final message = TextMessage.fromStream(
        clients.ollamaClient.chat.createStream(
          request: llama.ChatRequest(
            model: model!.name,
            messages: toApi(),
            stream: true,
            keepAlive: llama.KeepAlive.number(Preferences.instance.keepAlive),
            think: llama.ThinkValue.enabled(finalThink),
          ),
        ),
        sender: MessageSender.assistant,
        completer: completer,
        onContent: onContent,
        saveChat: () async {
          if (alive) await saveChat();
        },
      )..addListener(notifyListeners);
      _messages.add(message);

      final future = completer.future.catchError((e, s) {
        message
          .._locked = false
          .._includesError = true
          ..modify();
        Error.throwWithStackTrace(e, s);
      });
      if (awaitCompletion) await future;
    } else if (message is ImageMessage) {
      await message.computeImageMeta();
    }

    notifyListeners();
    if (alive) await saveChat();
  }

  void delete(Message message) {
    assert(alive, "Chat must be alive to be modified.");
    if (!alive) return;

    _messages.remove(message);
    message.removeListener(notifyListeners);
    notifyListeners();
    saveChat();
  }

  Future<void> saveChat() async {
    assert(alive, "Chat must be alive to be modified.");
    if (!alive) return;

    await chatDb
        .into(chatDb.chats)
        .insertOnConflictUpdate(
          ChatsCompanion(id: Value(id), json: Value(jsonEncode(toJson()))),
        );
  }

  Future<bool> _migrateImageStorageFormat() async {
    var didMigrate = false;
    for (var message in _messages.whereType<ImageMessage>()) {
      if (message.image.scheme != "ref") {
        final id = const Uuid().v4();
        final data = base64Decode(message.image.toString().split(",").last);
        await chatDb
            .into(chatDb.assets)
            .insert(
              AssetsCompanion(
                id: Value(id),
                chatId: Value(this.id),
                data: Value(data),
              ),
            );

        double? aspectRatio;
        int? width;
        if (message.aspectRatio == null || message.width == null) {
          try {
            final decodedImage = img.decodeImage(data);
            if (decodedImage != null) {
              aspectRatio = decodedImage.width / decodedImage.height;
              width = decodedImage.width;
            }
          } catch (_) {}
        } else {
          aspectRatio = message.aspectRatio;
          width = message.width;
        }

        message
          .._image = Uri.parse("ref://$id")
          .._aspectRatio = aspectRatio
          .._width = width;
        didMigrate = true;
      }
    }
    return didMigrate;
  }

  @override
  bool operator ==(Object other) => other is Chat && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

class ChatManager extends ChangeNotifier {
  static final ChatManager _instance = ChatManager._();
  static ChatManager get instance => _instance;

  String? _currentChatId;
  String? get currentChatId => _currentChatId;
  set currentChatId(String? id) {
    final chat = _chats.where((e) => e.id == id).firstOrNull;
    if (chat == null && id != null) {
      throw ArgumentError.value(id, "id", "Chat with this ID does not exist.");
    }

    _currentChatId = id;
    if (id != null) {
      if (chat!.model != null) {
        ModelManager.instance.currentModelName = chat.model!.name;
      }
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

    var stored = <String>[];

    final oldPrefs = await SharedPreferences.getInstance();
    final oldStored = oldPrefs.getStringList("chats") ?? [];
    if (oldStored.isNotEmpty) {
      stored = oldStored;
      await oldPrefs.remove("chats");
      await prefs!.remove("chats");
    }

    if (stored.isEmpty) {
      stored = await chatDb
          .select(chatDb.chats)
          .get()
          .then((rows) => rows.map((r) => r.json).toList());
    }

    _chats.clear();
    for (var chatJson in stored) {
      try {
        final chatData = jsonDecode(chatJson);

        final messages = <Message>[];
        String? system;

        final data = chatData["messages"] is String
            ? (jsonDecode(chatData["messages"]) as List)
            : chatData["messages"];

        for (var message in data) {
          if (message["role"] == "system") {
            system = message["content"];
            continue;
          }

          final constructor = Message.constructorForType(
            message["type"] ?? "text",
          );
          if (constructor == null) continue;
          messages.add(constructor.call(message));
        }

        _chats.add(
          Chat._(
            id: chatData["uuid"] ?? chatData["id"],
            modelName: chatData["model"],
            createdAt: getDateTimeFromMilliseconds(chatData["createdAt"]),
            title: chatData["title"],
            messages: messages,
            system: system,
          )..addListener(notifyListeners),
        );
      } catch (_) {
        rethrow;
      }
    }

    if (oldStored.isNotEmpty) await saveChats();
    notifyListeners();
  }

  Future<void> saveChats() async {
    for (var chat in _chats) {
      await chatDb
          .into(chatDb.chats)
          .insertOnConflictUpdate(
            ChatsCompanion(
              id: Value(chat.id),
              json: Value(jsonEncode(chat.toJson())),
            ),
          );
      if (await chat._migrateImageStorageFormat()) await chat.saveChat();
    }
  }

  Chat createChat({
    required BuildContext? context,
    Model? model,
    String? title,
    String? system,
  }) {
    final chat = Chat._(
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
    chat.saveChat();

    return chat;
  }

  void deleteChat(Chat chat) {
    _chats.remove(chat);
    chat.removeListener(notifyListeners);
    for (var message in chat.messages) {
      message.removeListener(chat.notifyListeners);
    }
    if (chat.completer.isCompleted == false) chat.completer.complete();

    if (_currentChatId == chat.id) _currentChatId = null;

    notifyListeners();
    (chatDb.delete(chatDb.chats)..where((c) => c.id.equals(chat.id))).go();
  }
}

// MARK: Delete Chat Dialog

Future<bool> showDeleteChatDialog(
  BuildContext context, {
  Chat? chat,
  FutureOr<void> Function()? onDelete,
}) {
  chat ??= ChatManager.instance.currentChat;
  final completer = Completer<bool>();
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
    onDelete?.call();
    completer.complete(true);
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

class _AnimatedWord {
  final String text;
  final WidgetSpan? widgetSpan;
  TextStyle? style;
  AnimationController? controller;

  bool get isWidget => widgetSpan != null;

  _AnimatedWord(this.text, this.style, [this.controller]) : widgetSpan = null;
  _AnimatedWord.forWidget(this.widgetSpan)
    : text = '',
      style = null,
      controller = null;
}

class ChatText extends StatefulWidget {
  final InlineSpan content;
  final Duration? flyInDuration;
  final Duration? wordDelay;
  final Widget? placeholder;

  const ChatText(
    this.content, {
    super.key,
    this.flyInDuration,
    this.wordDelay,
    this.placeholder,
  });

  @override
  State<ChatText> createState() => _ChatTextState();
}

class _ChatTextState extends State<ChatText> with TickerProviderStateMixin {
  final List<_AnimatedWord> _words = [];
  final List<_AnimatedWord> _queue = [];
  Timer? _delayTimer;
  DateTime? _lastWordShownAt;

  List<String> _splitWords(String text) {
    if (text.isEmpty) return const [];
    return text.split(RegExp(r'(?=\s)')).where((s) => s.isNotEmpty).toList();
  }

  List<_AnimatedWord> _flattenAll(InlineSpan span, [TextStyle? parent]) {
    final result = <_AnimatedWord>[];
    if (span is TextSpan) {
      final eff = (parent != null && span.style != null)
          ? parent.merge(span.style!)
          : (span.style ?? parent);
      if (span.text?.isNotEmpty ?? false) {
        result.add(_AnimatedWord(span.text!, eff));
      }
      for (var child in span.children ?? const <InlineSpan>[]) {
        result.addAll(_flattenAll(child, eff));
      }
    } else if (span is WidgetSpan) {
      result.add(_AnimatedWord.forWidget(span));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    for (var entry in _flattenAll(widget.content)) {
      if (entry.isWidget) {
        _words.add(entry);
      } else {
        for (var w in _splitWords(entry.text)) {
          _words.add(_AnimatedWord(w, entry.style));
        }
      }
    }
  }

  @override
  void didUpdateWidget(ChatText old) {
    super.didUpdateWidget(old);
    if (widget.content != old.content) _processUpdate();
  }

  void _enqueue(_AnimatedWord word) {
    if (widget.wordDelay == null) {
      word.controller?.forward();
      return;
    }
    _queue.add(word);
    _drainQueue();
  }

  void _drainQueue() {
    if ((_delayTimer?.isActive ?? false) || _queue.isEmpty) return;
    final remaining =
        widget.wordDelay! -
        (_lastWordShownAt != null
            ? DateTime.now().difference(_lastWordShownAt!)
            : widget.wordDelay!);
    if (remaining <= Duration.zero) {
      _lastWordShownAt = DateTime.now();
      _queue.removeAt(0).controller?.forward();
      if (_queue.isNotEmpty) _drainQueue();
    } else {
      _delayTimer = Timer(remaining, _drainQueue);
    }
  }

  void _cancelQueue() {
    _delayTimer?.cancel();
    _delayTimer = null;
    _lastWordShownAt = null;
    _queue.clear();
  }

  @override
  void dispose() {
    _cancelQueue();
    for (var w in _words) {
      w.controller?.dispose();
    }
    super.dispose();
  }

  void _processUpdate() {
    final newEntries = _flattenAll(widget.content);
    final newFullText = newEntries
        .where((e) => !e.isWidget)
        .map((e) => e.text)
        .join();
    final oldFullText = _words
        .where((w) => !w.isWidget)
        .map((w) => w.text)
        .join();

    if (newFullText == oldFullText) {
      _syncStyles(newEntries);
      setState(() {});
      return;
    }

    if (newFullText.startsWith(oldFullText)) {
      _animateAppended(newEntries, oldFullText.length);
    } else {
      _reset(newEntries);
    }
  }

  void _syncStyles(List<_AnimatedWord> entries) {
    final flat = <_AnimatedWord>[];
    for (var entry in entries) {
      if (entry.isWidget) continue;
      for (var w in _splitWords(entry.text)) {
        flat.add(_AnimatedWord(w, entry.style));
      }
    }
    final textWords = _words.where((w) => !w.isWidget).toList();
    for (var i = 0; i < textWords.length && i < flat.length; i++) {
      textWords[i].style = flat[i].style;
    }
  }

  void _animateAppended(List<_AnimatedWord> newEntries, int oldLength) {
    var seen = 0;
    for (var leaf in newEntries) {
      if (leaf.isWidget) {
        if (seen >= oldLength) _words.add(leaf);
        continue;
      }
      final leafEnd = seen + leaf.text.length;
      if (leafEnd <= oldLength) {
        seen = leafEnd;
        continue;
      }
      final start = (oldLength - seen).clamp(0, leaf.text.length);
      final newText = leaf.text.substring(start);
      for (var word in _splitWords(newText)) {
        final ctrl = AnimationController(
          value: 0.0,
          vsync: this,
          duration: widget.flyInDuration ?? Durations.medium1,
        );
        final entry = _AnimatedWord(word, leaf.style, ctrl);
        ctrl
          ..addListener(() {
            if (mounted) setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              entry.controller?.dispose();
              entry.controller = null;
            }
          });
        _words.add(entry);
        _enqueue(entry);
      }
      seen = leafEnd;
    }
  }

  void _reset(List<_AnimatedWord> entries) {
    _cancelQueue();
    for (var w in _words) {
      w.controller?.dispose();
    }
    _words.clear();
    for (var entry in entries) {
      if (entry.isWidget) {
        _words.add(entry);
      } else {
        for (var w in _splitWords(entry.text)) {
          _words.add(_AnimatedWord(w, entry.style));
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = _words.isEmpty;
    if (isEmpty && widget.placeholder != null) return widget.placeholder!;

    final defaultColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return AnimatedSize(
      alignment: Alignment.topLeft,
      duration: Durations.short2,
      child: Text.rich(
        TextSpan(
          children: _words
              .where((w) => w.controller?.status != AnimationStatus.dismissed)
              .map((word) {
                final alpha = word.controller?.value;
                if (alpha == null) {
                  return TextSpan(text: word.text, style: word.style);
                }

                final baseColor = word.style?.color ?? defaultColor;
                return TextSpan(
                  text: word.text,
                  style: (word.style ?? const TextStyle()).copyWith(
                    color: baseColor.withValues(alpha: alpha),
                  ),
                );
              })
              .toList(),
        ),
      ),
    );
  }
}
