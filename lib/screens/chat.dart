import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ollama_dart/ollama_dart.dart' as llama;
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import '../main.gr.dart';
import '../services/services.dart';
import '../widgets/child_size.dart';
import '../widgets/safe_area_presence.dart';
import '../widgets/two_state_widget.dart';

@RoutePage()
class ScreenNewChat extends StatefulWidget {
  const ScreenNewChat({super.key});

  @override
  State<ScreenNewChat> createState() => _ScreenNewChatState();
}

class _ScreenNewChatState extends State<ScreenNewChat> {
  late int greetingId;

  @override
  void initState() {
    super.initState();
    ChatManager.instance.addListener(onUpdate);
    shuffleGreeting();
  }

  @override
  void dispose() {
    ChatManager.instance.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (ChatManager.instance.currentChatId != null) {
      context.router.navigate(
        RouteChat(chatId: ChatManager.instance.currentChatId!),
      );
    }
  }

  void shuffleGreeting() => greetingId = math.Random().nextInt(5) + 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    final breakpoint = Breakpoint.of(context);
    final embeddedNavigation = breakpoint.panesRecommended >= 2;

    final appLocalizations = AppLocalizations.of(context);
    final user =
        Preferences.instance.user ??
        appLocalizations.newChatGreetingNameFallback;
    final greeting = switch (greetingId) {
      1 => appLocalizations.newChatGreeting1(user),
      2 => appLocalizations.newChatGreeting2(user),
      3 => appLocalizations.newChatGreeting3(user),
      4 => appLocalizations.newChatGreeting4(user),
      _ => appLocalizations.newChatGreeting5(user),
    };

    return _ChatFrame(
      placeSearchBar: !embeddedNavigation,
      builder: (context, safeAreaPadding, input) => Padding(
        padding: safeAreaPadding,
        child: VisibilityDetector(
          key: const Key("newChatGreeting"),
          onVisibilityChanged: (i) {
            if (i.visibleFraction <= 0) {
              shuffleGreeting();
              if (mounted) setState(() {});
            }
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    greeting,
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (input != null) ...[const SizedBox(height: 12), input],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class ScreenChat extends StatefulWidget {
  final String? chatId;
  const ScreenChat({super.key, @PathParam("id") this.chatId});

  @override
  State<ScreenChat> createState() => _ScreenChatState();
}

class _ScreenChatState extends State<ScreenChat> {
  final _controller = AutoScrollController();
  double? _preLastMessageHeight;

  List<Message> _messages = [];
  Chat? _chat;

  @override
  void initState() {
    super.initState();
    ChatManager.instance.addListener(onUpdate);
    checkChatId();
  }

  @override
  void dispose() {
    ChatManager.instance.removeListener(onUpdate);
    _chat?.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (ChatManager.instance.currentChatId != widget.chatId) {
      context.router.navigate(
        ChatManager.instance.currentChatId != null
            ? RouteChat(chatId: ChatManager.instance.currentChatId!)
            : const RouteNewChat(),
      );
    }

    if (mounted &&
        (_chat?.completer.isCompleted ?? false) &&
        (_chat?.messages.isNotEmpty ?? false) &&
        _messages != _chat!.messages) {
      _messages = _chat!.messages;
    }
    if (mounted) setState(() {});
  }

  Future<void> onNewMessages() async {
    if (_chat?.messages.isEmpty ?? true) return;
    final newMessages = _chat!.messages.where(
      (message) => !_messages.contains(message),
    );
    final firstNewMessage = newMessages.firstOrNull;
    if (firstNewMessage != null) {
      // TODO: improve scroll handling
      _controller.animateTo(
        0,
        duration: ExpressiveCurves.expressiveSpatial.fastDuration,
        curve: ExpressiveCurves.expressiveSpatial.fast,
      );
    }
  }

  @override
  void didUpdateWidget(covariant ScreenChat oldWidget) {
    super.didUpdateWidget(oldWidget);
    checkChatId();
  }

  void checkChatId() {
    if ((widget.chatId?.trim() ?? "").isEmpty ||
        !uuidRegex.hasMatch(widget.chatId!) ||
        !ChatManager.instance.chats.any((chat) => chat.id == widget.chatId)) {
      context.router.navigate(const RouteNewChat());
    } else if (widget.chatId != ChatManager.instance.currentChatId) {
      ChatManager.instance.currentChatId = widget.chatId!;
    }

    if (_chat == null || _chat?.id != widget.chatId) {
      _chat?.removeListener(onUpdate);
      _chat = ChatManager.instance.chats
          .where((chat) => chat.id == widget.chatId)
          .first;
      _chat?.addListener(onUpdate);
      _messages = _chat?.messages ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final adaptedOnSurface = adaptedOnSurfaceFromColorScheme(colorScheme);

    return _ChatFrame(
      onFirstToken: onNewMessages,
      builder: (_, safeAreaPadding, input) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: safeAreaPadding,
          controller: _controller,
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                _chat?.messages.asMap().entries.map((message) {
                  final lastIndex = _chat!.messages.length - 1;
                  final preLastIndex = lastIndex - 1;

                  Widget tmp = _ScreenChatTile(
                    message: message.value,
                    constraints: constraints,
                    index: message.key,
                    scrollController: _controller,
                    preLastMessageHeight:
                        (_preLastMessageHeight ?? 0) +
                        safeAreaPadding.top +
                        safeAreaPadding.bottom,
                    isLast: message.key == lastIndex,
                  );

                  if (message.key == preLastIndex) {
                    tmp = ChildSize(
                      onChange: (size) {
                        if (_preLastMessageHeight != size.height) {
                          _preLastMessageHeight = size.height;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) setState(() {});
                          });
                        }
                      },
                      child: tmp,
                    );
                  }
                  return tmp;
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}

class _ScreenChatTile extends StatelessWidget {
  final Message message;
  final BoxConstraints constraints;

  final int? index;
  final AutoScrollController? scrollController;

  final double? preLastMessageHeight;
  final bool isLast;

  const _ScreenChatTile({
    required this.message,
    required this.index,
    required this.constraints,
    required this.scrollController,
    required this.preLastMessageHeight,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = ColorScheme.of(context);
    final breakpoint = Breakpoint.of(context);

    final isUserMessage = message.sender == MessageSender.user;
    Widget tmp;

    switch (message) {
      case final TextMessage message:
        tmp = Text.rich(
          TextSpan(children: Markdown(message.content).toInlineSpans(context)),
        );
      case final ImageMessage message:
        // return Image(image:message.imageProvider);
        tmp = const Text("Image message");
    }

    if (tmp is Text) {
      tmp = Padding(
        padding: EdgeInsetsDirectional.only(
          start: breakpoint.spacing,
          end: breakpoint.spacing,
          top: breakpoint.spacing - 4,
          bottom: breakpoint.spacing - 4,
        ),
        child: tmp,
      );
    } else {
      tmp = Padding(
        padding: EdgeInsetsDirectional.all(breakpoint.spacing / 2),
        child: tmp,
      );
    }

    if (isUserMessage) {
      tmp = Align(
        alignment: AlignmentDirectional.centerEnd,
        child: IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: math.min(
                math.max(constraints.maxWidth / 3 * 2, 200),
                size.width * 0.8,
              ),
            ),
            decoration: BoxDecoration(
              color: adaptedOnSurfaceFromColorScheme(colorScheme),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(12),
                topEnd: Radius.circular(12),
                bottomStart: Radius.circular(12),
              ),
            ),
            child: tmp,
          ),
        ),
      );
    }

    if (isLast) {
      tmp = ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight - (preLastMessageHeight ?? 0),
        ),
        child: tmp,
      );
    }
    if (scrollController != null && index != null) {
      tmp = AutoScrollTag(
        key: ValueKey(message.id),
        controller: scrollController!,
        index: index!,
        child: tmp,
      );
    }

    return tmp;
  }
}

class _ChatFrame extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    EdgeInsetsDirectional safeAreaPadding,
    Widget? input,
  )
  builder;
  final bool placeSearchBar;
  final VoidCallback? onFirstToken;

  const _ChatFrame({
    required this.builder,
    this.placeSearchBar = true,
    this.onFirstToken,
  });

  @override
  State<_ChatFrame> createState() => _ChatFrameState();
}

class _ChatFrameState extends State<_ChatFrame> {
  Chat? _chat;
  bool _loading = false;
  double? _inputHeight;

  @override
  void initState() {
    super.initState();
    ChatManager.instance.addListener(onChatUpdate);
    onChatUpdate();
  }

  @override
  void dispose() {
    ChatManager.instance.removeListener(onChatUpdate);
    _chat?.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if ((_chat?.completer.isCompleted ?? false) && _loading != false) {
      _loading = false;
      if (mounted) setState(() {});
    } else if (_loading != true) {
      _loading = true;
      if (mounted) setState(() {});
    }
  }

  void onChatUpdate() {
    final chat = ChatManager.instance.currentChat;
    if (chat != _chat) {
      _chat?.removeListener(onUpdate);
      _chat = chat;
      _chat?.addListener(onUpdate);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    final halfSpacing = breakpoint.spacing / 2;

    final hasSafeAreaPadding =
        SafeAreaPresence.maybeOf(context)?.hasSafeAreaPadding ?? false;

    final inputPadding = breakpoint.panesRecommended >= 2
        ? EdgeInsetsDirectional.only(
            start: halfSpacing,
            end: halfSpacing,
            bottom: halfSpacing,
          )
        : EdgeInsetsDirectional.only(
            start: 2,
            end: 2,
            bottom: hasSafeAreaPadding ? 2 : breakpoint.spacing,
          );
    final input = Hero(
      tag: "chatScreenInput",
      child: AnimatedPadding(
        duration: ExpressiveCurves.standardSpatial.fastDuration,
        curve: ExpressiveCurves.standardEffects.fast,
        padding: inputPadding,
        child: ChildSize(
          onChange: (size) {
            if (_inputHeight != size.height) {
              _inputHeight = size.height;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() {});
              });
            }
          },
          child: _ChatInput(onFirstToken: widget.onFirstToken),
        ),
      ),
    );

    final safeAreaPadding = EdgeInsetsDirectional.only(
      top: breakpoint.spacing,
      bottom: _inputHeight != null
          ? _inputHeight! + inputPadding.bottom + breakpoint.spacing
          : 0,
    );

    final child = widget.builder.call(
      context,
      safeAreaPadding,
      widget.placeSearchBar ? null : input,
    );
    final stack = Stack(
      children: [
        child,
        Align(
          alignment: AlignmentGeometry.topCenter,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorScheme.of(context).surface,
                    ColorScheme.of(context).surface.withValues(alpha: 0),
                  ],
                ),
              ),
              child: SizedBox(
                height: breakpoint.spacing,
                width: double.infinity,
              ),
            ),
          ),
        ),
        if (_loading)
          const Align(
            alignment: AlignmentGeometry.topCenter,
            child: IgnorePointer(child: LinearProgressIndicator()),
          ),

        if (widget.placeSearchBar) ...[
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.5],
                    colors: [
                      ColorScheme.of(context).surface.withValues(alpha: 0),
                      ColorScheme.of(context).surface,
                    ],
                  ),
                ),
                child: SizedBox(
                  height: safeAreaPadding.bottom,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Align(alignment: AlignmentGeometry.bottomCenter, child: input),
        ],
      ],
    );
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 720 - halfSpacing),
        child: SizedBox.expand(child: stack),
      ),
    );
  }
}

class _ChatInput extends StatefulWidget {
  final VoidCallback? onFirstToken;
  const _ChatInput({this.onFirstToken});

  @override
  State<_ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<_ChatInput> {
  late final TextEditingController _controller = TextEditingController();
  late final FocusNode _focusNode = FocusNode(
    onKeyEvent: (_, event) {
      if (!HardwareKeyboard.instance.isShiftPressed &&
          event.logicalKey == LogicalKeyboardKey.enter) {
        if (event is KeyDownEvent) _submit();
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    },
  );

  bool _firstTokenLock = false;
  Chat? _chat;

  @override
  void initState() {
    super.initState();
    ModelManager.instance.addListener(onUpdate);
    ChatManager.instance.addListener(onChatUpdate);
    onChatUpdate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    ModelManager.instance.removeListener(onUpdate);
    ChatManager.instance.removeListener(onChatUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (mounted) setState(() {});
  }

  void onChatUpdate() {
    final chat = ChatManager.instance.currentChat;
    if (chat != _chat) {
      _chat?.removeListener(onUpdate);
      _chat = chat;
      _chat?.addListener(onUpdate);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _submit() async {
    _firstTokenLock = false;
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    var chat = ChatManager.instance.currentChat;
    final isNewChat = chat == null;
    if (isNewChat) {
      chat = ChatManager.instance.createChat(context: context);
      context.router.navigate(RouteChat(chatId: chat.id));
    }

    final wasFocused = _focusNode.hasFocus;
    _controller.clear();
    if (wasFocused) _focusNode.requestFocus();

    await errorGuard(
      context,
      "N89P97ND",
      () async => chat!.send(
        TextMessage(text, sender: .user),
        onContent: (_) {
          if (_firstTokenLock) return;
          _firstTokenLock = true;
          widget.onFirstToken?.call();
        },
      ),
      errorMessage: errorGuardErrorMessageWithFallbackSingle(
        llama.OllamaException,
        "Unable to send message",
      ),
      enableReporting: false,
    );

    if (!mounted || !chat.alive || !isNewChat) return;
    await errorGuard(
      context,
      "A02A05PB",
      () async => chat!.generateTitle(context: context, think: true),
      errorMessage: errorGuardErrorMessageWithFallbackSingle(
        llama.OllamaException,
        "Unable to generate chat title",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final adaptiveOnSurface = adaptedOnSurfaceFromColorScheme(colorScheme);

    final enabled = ModelManager.instance.currentModel != null;
    final opacity = enabled ? 1.0 : kDisabledOpacity;

    Widget enabledWidget({required Widget child}) => IgnorePointer(
      ignoring: !enabled,
      child: Opacity(opacity: opacity, child: child),
    );

    Padding leadingTrailingPaddingMap(e) => Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 8),
      child: e,
    );
    final leading = [
      enabledWidget(
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
        ),
      ),
    ];
    final trailing = [
      TwoStateWidgetManaged(
        state: _chat?.completer.isCompleted ?? true,
        from: IconButton.outlined(
          onPressed: _chat?.completer.complete,
          icon: const Icon(Icons.stop_rounded),
        ),
        to: enabledWidget(
          child: IconButton.filled(
            onPressed: _submit,
            icon: const Icon(Icons.arrow_upward_rounded),
          ),
        ),
      ),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56.0),
      child: Material(
        shadowColor: colorScheme.shadow,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: adaptiveOnSurface, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(56 / 2)),
        ),
        child: InkWell(
          onTap: enabled
              ? () {
                  if (!_focusNode.hasFocus) _focusNode.requestFocus();
                }
              : null,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56 / 2)),
          ),
          mouseCursor: enabled
              ? SystemMouseCursors.text
              : SystemMouseCursors.basic,
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ...leading.map(leadingTrailingPaddingMap),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsGeometry.symmetric(
                      horizontal: 8.0,
                      vertical: (56 - 24) / 2,
                    ),
                    child: Semantics(
                      inputType: SemanticsInputType.text,
                      child: Opacity(
                        opacity: opacity,
                        child: TextField(
                          autofocus: true,
                          onTapAlwaysCalled: true,
                          focusNode: _focusNode,
                          controller: _controller,
                          enabled: enabled,
                          autocorrect: true,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          minLines: 1,
                          maxLines: 9,
                          decoration:
                              InputDecoration(
                                hintText: appLocalizations.messageInputPlaceholder(
                                  Model.nameColoredStatic(
                                        name: ModelManager
                                            .instance
                                            .currentModelName,
                                        context: context,
                                      )?.first.text ??
                                      appLocalizations
                                          .messageInputPlaceholderModelPlaceholder,
                                ),
                              ).applyDefaults(
                                InputDecorationThemeData(
                                  hintStyle: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...trailing.map(leadingTrailingPaddingMap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatDetails extends StatelessWidget {
  final VoidCallback? onClose;
  final EdgeInsetsDirectional padding;
  const ChatDetails({
    super.key,
    this.onClose,
    this.padding = const EdgeInsetsDirectional.only(
      start: 24,
      end: 16,
      top: 16,
      bottom: 24,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final currentChat = ChatManager.instance.currentChat;

    var padding = this.padding;
    final hasSafeAreaPadding =
        SafeAreaPresence.maybeOf(context)?.hasSafeAreaPadding ?? false;
    if (hasSafeAreaPadding) {
      padding = padding.copyWith(top: 0, bottom: 0);
    }

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    appLocalizations.optionChatDetails,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsGeometry.directional(end: 8),
            child: SizedBox(
              width: double.infinity,
              // TODO: implement proper details view
              child: SingleChildScrollView(
                child: Text(
                  currentChat != null
                      ? "${currentChat.title}\n\nstats:\n${JsonEncoder.withIndent(" " * 2).convert(currentChat.messages.whereType<TextMessage>().lastOrNull?.stats?.toJson() ?? {})}"
                      : appLocalizations.optionChatDetailsNoChat,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
