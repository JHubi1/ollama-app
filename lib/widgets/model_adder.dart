import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ollama_dart/ollama_dart.dart' as ollama;
import 'package:url_launcher/url_launcher.dart';

import '../l10n/gen/app_localizations.dart';
import '../services/services.dart';
import 'alert_dialog_child.dart';

final modelTagRegex = RegExp(
  r"^((?:(?:(?:[a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])(?:\.(?:[a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]))*|\[(?:[a-fA-F0-9:]+)\])(?::[0-9]+)?/)?[a-z0-9]+(?:(?:[._]|__|[-]+)[a-z0-9]+)*(?:/[a-z0-9]+(?:(?:[._]|__|[-]+)[a-z0-9]+)*)*)(?::([\w][\w.-]{0,127}))?$",
);

Map<String, StreamSubscription<ollama.StatusEvent>> _downloadingModels = {};
Map<String, _DownloadingModelsState> _downloadingModelsState = {};

class _DownloadingModelsState with ChangeNotifier {
  double? progress;
  int? total;
  bool completedType;

  bool? pageState;

  bool cancelFlag;
  bool cancelledType;

  bool errorNotFoundType;
  bool errorNetworkType;
  bool errorCorruptionType;

  void _notify() => notifyListeners();

  _DownloadingModelsState()
    : progress = null,
      total = null,
      completedType = false,
      pageState = null,
      cancelFlag = false,
      cancelledType = false,
      errorNotFoundType = false,
      errorNetworkType = false,
      errorCorruptionType = false;
}

class ModelAdder extends StatefulWidget {
  const ModelAdder({super.key});

  @override
  State<ModelAdder> createState() => _ModelAdderState();
}

class _ModelAdderState extends State<ModelAdder> {
  bool? get _pageState =>
      modelName != null ? _downloadingModelsState[modelName]?.pageState : false;
  set _pageState(bool? value) => modelName != null
      ? _downloadingModelsState[modelName]!.pageState = value
      : null;
  bool _wantPop = false;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  String? Function() _errorText = () => null;
  bool _errorIsCorruption = false;

  String? modelName;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _downloadingModelsState.forEach(
      (_, state) => state.removeListener(onUpdate),
    );
    super.dispose();
  }

  Future<void> _downloadModel([String? model]) async {
    var modelName = model ?? _controller.text.trim();
    if (modelName.isEmpty) {
      _focusNode.requestFocus();
      return;
    }
    if (!modelName.contains(":")) {
      modelName = "$modelName:latest";
    }

    _errorText = () => null;
    _errorIsCorruption = false;
    if (mounted) setState(() {});

    if (ModelManager.instance.models.any((model) => model.name == modelName)) {
      _errorText = () =>
          AppLocalizations.of(context).modelDialogAddPromptAlreadyExists;
      if (mounted) setState(() {});
      _focusNode.requestFocus();
      return;
    }

    if (!modelTagRegex.hasMatch(modelName)) {
      _errorText = () =>
          AppLocalizations.of(context).modelDialogAddPromptInvalid;
      if (mounted) setState(() {});
      _focusNode.requestFocus();
      return;
    }

    _pageState = null;
    if (mounted) setState(() {});

    try {
      _downloadingModelsState
          .putIfAbsent(modelName, _DownloadingModelsState.new)
          .addListener(onUpdate);
      this.modelName = modelName;

      var sub = _downloadingModels[modelName];
      sub ??= ollamaClient.models
          .pullStream(
            request: ollama.PullRequest(model: modelName, stream: true),
          )
          .listen(
            (event) {
              final state = _downloadingModelsState[modelName]!;
              if (state.cancelFlag) {
                state
                  ..cancelledType = true
                  .._notify();
                this.modelName = null;
                _downloadingModels.remove(modelName);
                _downloadingModelsState.remove(modelName);
                sub?.cancel();
                return;
              } else if (event.status == "success") {
                state
                  ..completedType = true
                  .._notify();
                this.modelName = null;
                _downloadingModels.remove(modelName);
                _downloadingModelsState.remove(modelName);
                return;
              }
              if ((event.total ?? 0) == 0 && (event.progress ?? 0) == 0) return;

              _pageState = true;
              if ((event.progress ?? -1) > (state.progress ?? -1)) {
                state.progress = event.progress;
              }
              if ((event.total ?? -1) > (state.total ?? -1)) {
                state.total = event.total;
              }

              if (!_downloadingModels.containsKey(modelName)) {
                _downloadingModels[modelName] = sub!;
              }
              state._notify();
            },
            onError: (Object error) {
              final state = _downloadingModelsState[modelName];
              if (error is ollama.StreamException) {
                if (error.message.contains("EOF")) {
                  state?.errorCorruptionType = true;
                } else {
                  state?.errorNotFoundType = true;
                }
              } else {
                state?.errorNetworkType = true;
              }
              state?._notify();
              this.modelName = null;
              _downloadingModels.remove(modelName);
              _downloadingModelsState.remove(modelName);
              sub?.cancel();
            },
          );
    } catch (_) {
      if (!mounted) return;
      _downloadingModelsState[modelName]
        ?..errorNetworkType = true
        .._notify();
      _downloadingModels.remove(modelName);
      _downloadingModelsState.remove(modelName);
      if (mounted) {
        setState(() {});
        _focusNode.requestFocus();
      }
    }
  }

  void onUpdate() {
    final state = modelName != null ? _downloadingModelsState[modelName] : null;
    if (state == null || !mounted) return;
    if (state.completedType || state.cancelledType) {
      final modelName = state.completedType ? this.modelName : null;
      ModelManager.instance.loadModels().then((_) {
        if (mounted) Navigator.of(context).pop(modelName);
      });
      return;
    } else if (state.errorNotFoundType ||
        state.errorNetworkType ||
        state.errorCorruptionType) {
      _errorText = () {
        if (state.errorNotFoundType) {
          return AppLocalizations.of(context).modelDialogAddPromptNotFound;
        } else if (state.errorNetworkType) {
          return AppLocalizations.of(context).modelDialogAddPromptNetworkError;
        } else if (state.errorCorruptionType) {
          _errorIsCorruption = true;
          return AppLocalizations.of(
            context,
          ).modelDialogAddPromptCorruptionError;
        }
        return null;
      };
      if (mounted) setState(() {});
      _focusNode.requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = modelName != null ? _downloadingModelsState[modelName] : null;

    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final breakpoint = Breakpoint.of(context);
    final embeddedNavigation = breakpoint.panesRecommended >= 2;

    final alignment = !embeddedNavigation
        ? AlignmentDirectional.bottomCenter
        : AlignmentDirectional.topStart;
    const constraints = BoxConstraints(minWidth: 280, maxWidth: 360);

    final childInput = AlertDialogChild(
      key: const ValueKey("input"),
      title: Text(appLocalizations.modelDialogAddPromptTitle),
      content: SizedBox(
        width: 560,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(appLocalizations.modelDialogAddPromptDescription),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              onSubmitted: (_) => _downloadModel(),
              decoration: InputDecoration(
                hintText: "gemma4:latest",
                errorText: _errorText.call(),
                errorMaxLines: 4,
              ),
            ),

            if (_errorIsCorruption) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                minTileHeight: 0,
                title: Text.rich(
                  TextSpan(
                    style: TextStyle(color: colorScheme.error),
                    children: [
                      TextSpan(text: appLocalizations.learnMore),
                      const TextSpan(text: " "),
                      WidgetSpan(
                        child: Builder(
                          builder: (context) => Transform.translate(
                            offset: const Offset(0, -1),
                            child: Icon(
                              Icons.open_in_new,
                              size: DefaultTextStyle.of(context).style.fontSize,
                              color: colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => launchUrl(
                  webOnlyWindowName: "_blank",
                  Uri.parse(
                    "https://github.com/ollama/ollama/issues/8088#issuecomment-2541889671",
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: appLocalizations
                          .modelDialogAddPromptCorruptionErrorSolution
                          .split("\n")
                          .first,
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(
                      text: r"$ rm -f $OLLAMA_MODELS/blobs/sha256-*partial*",
                      style: textTheme.labelMedium?.copyWith(
                        fontFamily: "GoogleSansCode",
                        color: colorScheme.error,
                      ),
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(
                      text: appLocalizations
                          .modelDialogAddPromptCorruptionErrorSolution
                          .split("\n")
                          .last,
                    ),
                  ],
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ),
            ],

            if (_downloadingModels.isNotEmpty) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Card.outlined(
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 6,
                          start: 8,
                        ),
                        child: Text(appLocalizations.modelDialogAddCurrently),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 4,
                          bottom: 8,
                          start: 8,
                          end: 8,
                        ),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: _downloadingModels.keys
                              .map(
                                (modelName) => ActionChip(
                                  label: Text(modelName),
                                  onPressed: () => _downloadModel(modelName),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.modelDialogAddCancelConfirm),
        ),
        TextButton(
          onPressed: _downloadModel,
          child: Text(appLocalizations.modelDialogAdd),
        ),
      ],
    );
    const childLoading = SizedBox(
      key: ValueKey("loading"),
      width: 560,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: LinearProgressIndicator(),
      ),
    );
    final childDownload = Builder(
      builder: (context) {
        final closeInput = [
          if (embeddedNavigation) const Divider(height: 1),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 24,
              bottom: 4,
              start: 24,
              end: 24,
            ),
            child: Text(appLocalizations.modelDialogAddCancelTitle),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 24,
              start: 24,
              end: 24,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () async => state!.cancelFlag = true,
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                  ),
                  child: Text(appLocalizations.modelDialogAddCancelConfirm),
                ),
                const SizedBox(width: 4),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(appLocalizations.modelDialogAddCancelHide),
                ),
              ],
            ),
          ),
          if (!embeddedNavigation) const Divider(height: 1),
        ];
        return SizedBox(
          key: const ValueKey("download"),
          width: 560,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_wantPop && !embeddedNavigation) ...closeInput,
              Padding(
                padding: const EdgeInsets.all(24),
                child: ListTile(
                  minTileHeight: 0,
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Builder(
                    builder: (context) => Text(
                      modelName ?? appLocalizations.noSelectedModel,
                      style: DefaultTextStyle.of(
                        context,
                      ).style.copyWith(fontFamily: "GoogleSansCode"),
                    ),
                  ),
                  subtitle: Builder(
                    builder: (context) => Wrap(
                      children: [
                        Text(
                          NumberFormat.decimalPercentPattern(
                            locale: appLocalizations.localeName,
                            decimalDigits: 2,
                          ).format(state?.progress ?? 0),
                          style: DefaultTextStyle.of(context).style.copyWith(
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(" " * 3),
                        const Text("/"),
                        Text(" " * 3),
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0, -1),
                                  child: Icon(
                                    Icons.sd_storage_outlined,
                                    size: DefaultTextStyle.of(
                                      context,
                                    ).style.fontSize,
                                  ),
                                ),
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                text: bytesToHumanReadable(
                                  state?.total ?? 0,
                                  locale: appLocalizations.localeName,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: CircularProgressIndicator(
                    value: state?.progress ?? 0,
                  ),
                ),
              ),
              if (_wantPop && embeddedNavigation) ...closeInput,
            ],
          ),
        );
      },
    );

    return PopScope(
      canPop: _pageState == false,
      onPopInvokedWithResult: (didPop, result) {
        if (_pageState != true || _wantPop) return;
        _wantPop = true;
        if (mounted) setState(() {});
      },
      child: Dialog(
        alignment: alignment,
        constraints: constraints,
        insetPadding: const EdgeInsets.all(12), // 24
        child: AnimatedSize(
          duration: ExpressiveCurves.expressiveSpatial.normalDuration,
          curve: ExpressiveCurves.expressiveSpatial.normal,
          alignment: embeddedNavigation
              ? AlignmentGeometry.topCenter
              : AlignmentGeometry.bottomCenter,
          child: AnimatedSwitcher(
            duration: ExpressiveCurves.expressiveSpatial.normalDuration,
            switchInCurve: ExpressiveCurves.expressiveSpatial.normal,
            switchOutCurve: ExpressiveCurves.expressiveEffects.slow.flipped,
            transitionBuilder: (child, animation) => SizeTransition(
              sizeFactor: animation,
              alignment: embeddedNavigation
                  ? AlignmentDirectional.bottomCenter
                  : AlignmentDirectional.topCenter,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: _pageState == null
                ? childLoading
                : (_pageState! ? childDownload : childInput),
          ),
        ),
      ),
    );
  }
}

Future<String?> showModelAdderDialog(BuildContext context) async =>
    showDialog<String>(
      context: context,
      builder: (context) => const ModelAdder(),
    );
