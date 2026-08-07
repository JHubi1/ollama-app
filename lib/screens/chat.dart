import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ollama_dart/ollama_dart.dart' as llama;
import 'package:visibility_detector/visibility_detector.dart';

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import '../main.gr.dart';
import '../services/services.dart';
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
    if (mounted) setState(() {});
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

    _chat?.removeListener(onUpdate);
    _chat = ChatManager.instance.chats
        .where((chat) => chat.id == widget.chatId)
        .first;
    _chat?.addListener(onUpdate);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final adaptedOnSurface = adaptedOnSurfaceFromColorScheme(colorScheme);

    return _ChatFrame(
      builder: (context, safeAreaPadding, input) {
        final msg = _chat?.messages
            .where((m) => m.sender == .assistant)
            .whereType<TextMessage>()
            .lastOrNull;
        return Text(
          "${msg?.thinking ?? "<dumdum>"}\n\n${msg?.content ?? "<none>"}\n\n${msg?.stats?.toJson() ?? "<no stats>"}",
        );
      },
    );
  }
}

class _ChatFrame extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    EdgeInsetsGeometry safeAreaPadding,
    Widget? input,
  )
  builder;
  final bool placeSearchBar;
  const _ChatFrame({required this.builder, this.placeSearchBar = true});

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    final halfSpacing = breakpoint.spacing / 2;

    final input = Hero(
      tag: "chatScreenInput",
      child: Align(
        alignment: AlignmentGeometry.bottomCenter,
        child: AnimatedPadding(
          duration: ExpressiveCurves.standardSpatial.fastDuration,
          curve: ExpressiveCurves.standardEffects.fast,
          padding: breakpoint.panesRecommended >= 2
              ? EdgeInsetsGeometry.only(
                  left: halfSpacing,
                  right: halfSpacing,
                  bottom: halfSpacing,
                )
              : EdgeInsetsGeometry.only(bottom: breakpoint.spacing),
          child: const _ChatInput(),
        ),
      ),
    );

    final child = builder.call(
      context,
      EdgeInsetsGeometry.zero,
      placeSearchBar ? null : input,
    );
    final stack = Stack(children: [child, if (placeSearchBar) input]);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 720 - halfSpacing),
        child: SizedBox.expand(child: stack),
      ),
    );
  }
}

class _ChatInput extends StatefulWidget {
  const _ChatInput();

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
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    var chat = ChatManager.instance.currentChat;
    final isNewChat = chat == null;
    if (isNewChat) {
      chat = ChatManager.instance.createChat(context: context);
      context.router.navigate(RouteChat(chatId: chat.id));
    }

    _controller.clear();

    await errorGuard(
      context,
      "N89P97ND",
      () async => chat!.send(TextMessage(text, sender: .user)),
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
          onPressed: () => _chat?.completer.complete(),
          icon: const Icon(Icons.stop_rounded),
        ),
        to: enabledWidget(
          child: IconButton.filled(
            onPressed: () {},
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
                          onSubmitted: (value) => _submit(),
                          controller: _controller,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          enabled: enabled,
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
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
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
  final EdgeInsetsGeometry padding;
  const ChatDetails({
    super.key,
    this.onClose,
    this.padding = const EdgeInsetsGeometry.directional(
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

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
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
