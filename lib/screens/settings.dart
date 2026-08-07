import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide RouteSettings;

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import '../main.gr.dart';
import '../services/services.dart';
import '../widgets/alpha_beta.dart';
import '../widgets/child_size_notifier.dart';
import '../widgets/sized_circular_progress_indicator.dart';
import '../widgets/two_state_widget.dart';

@RoutePage()
class ScreenSettingsShell extends StatelessWidget {
  const ScreenSettingsShell({super.key});

  @override
  Widget build(_) => const AutoRouter();
}

@RoutePage()
class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    if (breakpoint.panesRecommended >= 2) {
      context.router.navigate(const RouteSettingsOverview()).then((_) {
        if (!context.mounted) return;
        context.router.removeWhere((e) => e.name == RouteSettings.page.name);
      });
    }

    return const SizedBox.expand(child: SettingsOptions());
  }
}

class SettingsOptions extends StatefulWidget {
  final bool embeddedNavigation;
  const SettingsOptions({super.key, this.embeddedNavigation = false});

  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {
  StreamSubscription<void>? _routerStream;
  String? path;

  @override
  void initState() {
    super.initState();
    path = GlobalNavigationObserver.path;
    _routerStream = GlobalNavigationObserver.routerStream.listen(onUpdate);
  }

  @override
  void dispose() {
    _routerStream?.cancel();
    super.dispose();
  }

  void onUpdate(_) {
    if (GlobalNavigationObserver.path != null) {
      path = GlobalNavigationObserver.path;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    Widget optionTile({
      required String title,
      required String? subtitle,
      required Widget leading,
      required PageRouteInfo<Object?> route,
      required String path,
      bool isBetaFeature = false,
    }) => AnimatedContainer(
      duration: ExpressiveCurves.expressiveEffects.fastDuration,
      curve: ExpressiveCurves.expressiveEffects.fast,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border:
            (this.path?.contains("/settings/$path") ?? false) &&
                widget.embeddedNavigation
            ? Border.all(color: colorScheme.outline, width: 2)
            : Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0),
                width: 2,
              ),
      ),
      child: ListTile(
        leading: leading,
        title: Beta(showBadge: isBetaFeature, child: Text(title)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () async {
          await context.router.navigate(route);
          if (context.mounted) setState(() {});
        },
      ),
    );

    return ListView(
      children: [
        if (!widget.embeddedNavigation) ...[
          const SettingsOverviewHostInput(
            embeddedNavigation: false,
            padding: EdgeInsetsGeometry.directional(top: 8),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top: 16, start: 128, end: 128),
            child: Divider(),
          ),
        ],
        if (widget.embeddedNavigation)
          optionTile(
            title: appLocalizations.settingsTitleOverview,
            subtitle: appLocalizations.settingsDescriptionOverview,
            leading: const Icon(Icons.dashboard_rounded),
            route: const RouteSettingsOverview(),
            path: "overview",
          ),
        optionTile(
          title: appLocalizations.settingsTitleBehavior,
          subtitle: appLocalizations.settingsDescriptionBehavior,
          leading: const Icon(Icons.psychology),
          route: const RouteSettingsBehavior(),
          path: "behavior",
        ),
        optionTile(
          title: appLocalizations.settingsTitleInterface,
          subtitle: appLocalizations.settingsDescriptionInterface,
          leading: const Icon(Icons.palette),
          route: const RouteSettingsInterface(),
          path: "interface",
        ),
        optionTile(
          title: appLocalizations.settingsTitleVoice,
          subtitle: appLocalizations.settingsDescriptionVoice,
          leading: const Icon(Icons.record_voice_over),
          route: const RouteSettingsVoice(),
          path: "voice",
          isBetaFeature: true,
        ),
        optionTile(
          title: appLocalizations.settingsTitleExport,
          subtitle: appLocalizations.settingsDescriptionExport,
          leading: const Icon(Icons.file_upload),
          route: const RouteSettingsExport(),
          path: "export",
        ),
        optionTile(
          title: appLocalizations.settingsTitleAbout,
          subtitle: appLocalizations.settingsDescriptionAbout,
          leading: const Icon(Icons.help_outline),
          route: const RouteSettingsAbout(),
          path: "about",
        ),
      ],
    );
  }
}

class SettingsOverviewHostInput extends StatefulWidget {
  final bool embeddedNavigation;
  final EdgeInsetsGeometry? padding;
  const SettingsOverviewHostInput({
    super.key,
    required this.embeddedNavigation,
    this.padding,
  });

  @override
  State<SettingsOverviewHostInput> createState() =>
      _SettingsOverviewHostInputState();
}

class _SettingsOverviewHostInputState extends State<SettingsOverviewHostInput> {
  late final TextEditingController _controller;
  String? _oldHostFromHostManager;

  bool _loading = false;
  HostSettingError? _error;

  @override
  void initState() {
    super.initState();
    HostManager.instance.addListener(onUpdate);

    _oldHostFromHostManager = HostManager.instance.host?.toString();
    _controller = TextEditingController(text: _oldHostFromHostManager);
  }

  @override
  void dispose() {
    HostManager.instance.removeListener(onUpdate);
    _controller.dispose();
    super.dispose();
  }

  void onUpdate() {
    final currentHostFromHostManager = HostManager.instance.host?.toString();
    if (currentHostFromHostManager != _oldHostFromHostManager &&
        _controller.text == _oldHostFromHostManager) {
      _oldHostFromHostManager = currentHostFromHostManager;
      _controller.text = currentHostFromHostManager ?? "";
    }

    if (mounted) setState(() {});
  }

  Future<void> _submit() async {
    if (_loading) return;

    final value = _controller.text.trim();
    if (value.isEmpty && HostManager.instance.host == null) return;

    _loading = true;
    _error = null;
    if (mounted) setState(() {});

    if (value.isEmpty) {
      await Future.delayed(Durations.medium1);
      HostManager.instance.host = null;
      _loading = false;
      if (mounted) setState(() {});
      return;
    }

    final error = (await Future.wait([
      HostManager.instance.smartSetHost(context, value),
      Future.delayed(Durations.long1),
    ])).first;

    _loading = false;
    _error = error;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = ColorScheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final errorStyle = _error != null;
    final errorTitle = _error?.title(context);
    final errorDescription = _error?.description(context);

    Widget iconRow(
      String text,
      Widget Function(Color color) icon, {
      String? subtitle,
      bool errorStyle = false,
      bool missingStyle = false,
      bool validStyle = false,
    }) {
      final color = errorStyle
          ? colorScheme.error
          : (missingStyle
                ? Colors.orange.harmonizeWith(colorScheme.primary)
                : (validStyle
                      ? Colors.green.harmonizeWith(colorScheme.primary)
                      : colorScheme.onSurfaceVariant.withValues(
                          alpha: kDisabledOpacity,
                        )));
      return ListTile(
        dense: true,
        contentPadding: const EdgeInsetsDirectional.only(top: 4),
        minTileHeight: 0,
        minVerticalPadding: 0,
        isThreeLine: subtitle != null,
        leading: icon.call(color),
        title: Builder(
          builder: (context) => Text(
            text,
            style: DefaultTextStyle.of(
              context,
            ).style.copyWith(color: color, fontFamily: "GoogleSansCode"),
          ),
        ),
        subtitle: subtitle != null
            ? Builder(
                builder: (context) => Text(
                  subtitle,
                  style: DefaultTextStyle.of(
                    context,
                  ).style.copyWith(color: color),
                ),
              )
            : null,
      );
    }

    return AnimatedSize(
      duration: ExpressiveCurves.expressiveSpatial.fastDuration,
      curve: ExpressiveCurves.expressiveSpatial.fast,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: TextField(
          controller: _controller,
          onSubmitted: (_) => _submit(),
          enabled: !_loading && !useHost,
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: appLocalizations.settingsHost,
            hintText: "https://localhost:11434",
            error: errorStyle
                ? iconRow(
                    errorTitle ?? "",
                    (color) => Icon(Icons.error_outline, color: color),
                    subtitle: errorDescription,
                    errorStyle: true,
                  )
                : null,
            helper: iconRow(
              _loading
                  ? appLocalizations.settingsHostChecking
                  : (HostManager.instance.host == null
                        ? appLocalizations.settingsHostMissing
                        : appLocalizations.settingsHostValid),
              (color) => TwoStateWidgetManaged(
                state: _loading,
                from: HostManager.instance.host == null
                    ? Icon(Icons.warning_amber, color: color)
                    : Icon(Icons.check_outlined, color: color),
                to: Icon(Icons.search_outlined, color: color),
              ),
              missingStyle: HostManager.instance.host == null && !_loading,
              validStyle: !_loading,
            ),
            prefixIcon: !widget.embeddedNavigation
                ? Padding(
                    padding: const EdgeInsetsDirectional.only(start: 4),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          clipBehavior: Clip.antiAlias,
                          isScrollControlled: true,
                          builder: (_) =>
                              const SettingsOverviewHostHeadersInputMobileSheet(),
                        );
                      },
                      tooltip: appLocalizations.tooltipAddHostHeaders,
                      icon: Icon(
                        Icons.data_object_outlined,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : null,
            suffixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(end: 4),
              child: _loading
                  ? SizedCircularProgressIndicator(
                      dimension: theme.iconTheme.size ?? 24,
                      padding: EdgeInsets.zero,
                    )
                  : IconButton(
                      icon: const Icon(Icons.save),
                      tooltip: appLocalizations.tooltipSend,
                      onPressed: _submit,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsOverviewHostHeadersInputMobileSheet extends StatefulWidget {
  const SettingsOverviewHostHeadersInputMobileSheet({super.key});

  @override
  State<SettingsOverviewHostHeadersInputMobileSheet> createState() =>
      _SettingsOverviewHostHeadersInputMobileSheetState();
}

class _SettingsOverviewHostHeadersInputMobileSheetState
    extends State<SettingsOverviewHostHeadersInputMobileSheet> {
  double? _childHeight;

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxExtend = ((_childHeight ?? 0) / constraints.maxHeight).clamp(
          0.0,
          1.0,
        );

        final initialChildSize = maxExtend.clamp(0.05, 0.85);
        final minChildSize = 0.05.clamp(0.05, initialChildSize);
        final maxChildSize = 0.85.clamp(initialChildSize, 0.85);

        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: MeasureSize(
              onChange: (size) {
                _childHeight = size.height;
                if (mounted) setState(() {});
              },
              child: Padding(
                padding: EdgeInsetsDirectional.all(breakpoint.spacing),
                child: const SettingsOverviewHostHeadersInput(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SettingsOverviewHostHeadersInput extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  const SettingsOverviewHostHeadersInput({super.key, this.padding});

  @override
  State<SettingsOverviewHostHeadersInput> createState() =>
      _SettingsOverviewHostHeadersInputState();
}

class _SettingsOverviewHostHeadersInputState
    extends State<SettingsOverviewHostHeadersInput> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late final Map<String, String> _headers;

  @override
  void initState() {
    super.initState();
    Preferences.instance.addListener(onUpdate);
    _headers = Preferences.instance.hostHeaders;
  }

  @override
  void dispose() {
    Preferences.instance.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    final newHeaders = Preferences.instance.hostHeaders;
    final diff = <String, String?>{};

    for (final key in newHeaders.keys) {
      if (!_headers.containsKey(key) || _headers[key] != newHeaders[key]) {
        diff[key] = newHeaders[key]!;
      }
    }
    for (final key in _headers.keys) {
      if (!newHeaders.containsKey(key)) {
        diff[key] = null;
      }
    }

    final listState = _listKey.currentState;
    if (listState != null) {
      for (final key in diff.keys) {
        final value = diff[key];
        if (value == null) {
          final index = _headers.keys.toList().indexOf(key);
          if (index != -1) {
            final oldValue = _headers[key];
            _headers.remove(key);
            listState.removeItem(
              index,
              (context, animation) => SizeTransition(
                sizeFactor: animation,
                child: SettingsOverviewHostHeadersInputTile(
                  index: index,
                  headerKey: key,
                  headerValue: oldValue ?? "",
                  onChanged: (_, _) {},
                ),
              ),
            );
          }
        } else {
          final index = _headers.keys.toList().indexOf(key);
          if (index == -1) {
            _headers[key] = value;
            listState.insertItem(_headers.length - 1);
          } else {
            _headers[key] = value;
            listState.setState(() {});
          }
        }
      }
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tmp = AnimatedList(
      key: _listKey,
      initialItemCount: _headers.length + 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final header = _headers.entries.toList().elementAtOrNull(index);
        return SizeTransition(
          sizeFactor: animation,
          child: SettingsOverviewHostHeadersInputTile(
            index: index,
            headerKey: header?.key ?? "",
            headerValue: header?.value ?? "",
            onChanged: (key, value) {
              final headers = _headers.entries.toList();
              final currentElement = headers.elementAtOrNull(index);
              if (key == null || value == null) {
                if (currentElement != null) {
                  headers.removeAt(index);
                  _headers
                    ..clear()
                    ..addEntries(headers);
                  _listKey.currentState?.removeItem(
                    index,
                    (context, animation) => SizeTransition(
                      sizeFactor: animation,
                      child: SettingsOverviewHostHeadersInputTile(
                        index: index,
                        headerKey: currentElement.key,
                        headerValue: currentElement.value,
                        onChanged: (_, _) {},
                      ),
                    ),
                  );
                }
              } else {
                if (currentElement != null) {
                  headers[index] = MapEntry(key, value);
                  _headers
                    ..clear()
                    ..addEntries(headers);
                } else {
                  headers.add(MapEntry(key, value));
                  _headers
                    ..clear()
                    ..addEntries(headers);
                  _listKey.currentState?.insertItem(headers.length - 1);
                }
              }
              Preferences.instance.hostHeaders = Map.fromEntries(headers);
            },
          ),
        );
      },
    );
    return Padding(padding: widget.padding ?? EdgeInsets.zero, child: tmp);
  }
}

class SettingsOverviewHostHeadersInputTile extends StatefulWidget {
  final int index;
  final String headerKey;
  final String headerValue;
  final void Function(String? key, String? value) onChanged;

  const SettingsOverviewHostHeadersInputTile({
    super.key,
    required this.index,
    required this.headerKey,
    required this.headerValue,
    required this.onChanged,
  });

  @override
  State<SettingsOverviewHostHeadersInputTile> createState() =>
      _SettingsOverviewHostHeadersInputTileState();
}

class _SettingsOverviewHostHeadersInputTileState
    extends State<SettingsOverviewHostHeadersInputTile> {
  bool _noUpdateFlag = false;
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;

  late final FocusNode _keyFocusNode;
  late final FocusNode _valueFocusNode;

  String? Function() _keyErrorText = () => null;
  final Set<String> _defaultAllowedHeaders = {
    "authorization",
    "content-type",
    "user-agent",
    "accept",
    "x-requested-with",
    "openai-beta",
    "x-stainless-arch",
    "x-stainless-async",
    "x-stainless-custom-poll-interval",
    "x-stainless-helper-method",
    "x-stainless-lang",
    "x-stainless-os",
    "x-stainless-package-version",
    "x-stainless-poll-helper",
    "x-stainless-retry-count",
    "x-stainless-runtime",
    "x-stainless-runtime-version",
    "x-stainless-timeout",
  };

  @override
  void initState() {
    super.initState();

    _keyController = TextEditingController(text: widget.headerKey)
      ..addListener(onUpdate);
    _valueController = TextEditingController(text: widget.headerValue)
      ..addListener(onUpdate);

    _keyFocusNode = FocusNode()..addListener(onUpdateFocus);
    _valueFocusNode = FocusNode()..addListener(onUpdateFocus);

    WidgetsBinding.instance.addPostFrameCallback((_) => onUpdateFocus(true));
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    _keyFocusNode.dispose();
    _valueFocusNode.dispose();
    super.dispose();
  }

  void onUpdate() {
    if (_noUpdateFlag) {
      _noUpdateFlag = false;
      return;
    }

    final newKey = _keyController.text.trim();
    final newValue = _valueController.text.trim();

    if (newKey.isEmpty || newValue.isEmpty) {
      if (newKey.isEmpty && newValue.isEmpty) widget.onChanged(null, null);
      return;
    }

    if (newKey.isNotEmpty &&
        Preferences.instance.hostHeaders.entries.toList().asMap().entries.any(
          (e) => e.value.key == newKey && e.key != widget.index,
        )) {
      _keyErrorText = () {
        if (newKey != _keyController.text) return null;
        final appLocalizations = AppLocalizations.of(context);
        return appLocalizations.settingsHostHeaderDuplicate(newKey);
      };
      if (mounted) setState(() {});
      return;
    }

    if (newKey != widget.headerKey || newValue != widget.headerValue) {
      _keyErrorText = () => null;
      widget.onChanged(
        newKey.isEmpty ? null : newKey,
        newValue.isEmpty ? null : newValue,
      );
    }
    if (mounted) setState(() {});
  }

  void onUpdateFocus([bool force = false]) {
    if ((!_keyFocusNode.hasFocus || force) &&
        _keyController.text.isNotEmpty &&
        !_defaultAllowedHeaders.contains(_keyController.text.toLowerCase()) &&
        widget.index != Preferences.instance.hostHeaders.length &&
        kIsWeb) {
      _keyErrorText = () {
        if (_keyController.text.isEmpty) return null;
        final appLocalizations = AppLocalizations.of(context);
        return appLocalizations.settingsHostHeaderUnsupported(
          _keyController.text,
        );
      };
    }
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(SettingsOverviewHostHeadersInputTile oldWidget) {
    if (_keyController.text != widget.headerKey) {
      _noUpdateFlag = true;
      _keyController.text = widget.headerKey;
      onUpdateFocus(true);
    }
    if (_valueController.text != widget.headerValue) {
      _noUpdateFlag = true;
      _valueController.text = widget.headerValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final isLast = widget.index == Preferences.instance.hostHeaders.length;
    final isDummy = widget.headerKey.isEmpty && widget.headerValue.isEmpty;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: AnimatedSize(
            duration: ExpressiveCurves.expressiveEffects.fastDuration,
            curve: ExpressiveCurves.expressiveEffects.fast,
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _keyController,
              focusNode: _keyFocusNode,
              autofocus: false,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                label: Text(appLocalizations.settingsHostHeaderHeaderName),
                hintText: "Authorization",
                helperText: _keyErrorText.call(),
                helperStyle: textTheme.bodySmall?.copyWith(
                  color: Colors.orange.harmonizeWith(colorScheme.primary),
                ),
                helperMaxLines: 3,
              ),
            ),
          ),
        ),
        Text(" " * 3),
        Expanded(
          flex: 3,
          child: TextField(
            controller: _valueController,
            focusNode: _valueFocusNode,
            autofocus: false,
            textInputAction: isLast
                ? TextInputAction.done
                : TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              label: Text(appLocalizations.settingsHostHeaderHeaderValue),
              hintText: "Bearer XXX",
            ),
          ),
        ),
        isDummy
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              )
            : IconButton(
                onPressed: () => widget.onChanged(null, null),
                icon: const Icon(Icons.close),
              ),
      ],
    );
  }
}

class SettingsPageContainmentBox extends StatefulWidget {
  final List<Widget> Function(BuildContext context, double halfSpacing)
  itemBuilder;

  const SettingsPageContainmentBox({super.key, required this.itemBuilder});

  @override
  State<SettingsPageContainmentBox> createState() =>
      _SettingsPageContainmentBoxState();
}

class _SettingsPageContainmentBoxState
    extends State<SettingsPageContainmentBox> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    final halfSpacing = breakpoint.spacing / 2;

    return ListView(
      children: widget.itemBuilder
          .call(context, halfSpacing)
          .map(
            (widget) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 560 - halfSpacing),
                  child: SizedBox(width: 560, child: widget),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

@RoutePage()
class ScreenSettingsOverview extends StatelessWidget {
  const ScreenSettingsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    if (breakpoint.panesRecommended < 2) {
      context.router.navigate(const RouteSettings()).then((_) {
        if (!context.mounted) return;
        context.router.removeWhere(
          (e) => e.name == RouteSettingsOverview.page.name,
        );
      });
    }

    return SettingsPageContainmentBox(
      itemBuilder: (context, halfSpacing) => [
        SettingsOverviewHostInput(
          embeddedNavigation: true,
          padding: EdgeInsetsGeometry.directional(top: 4 + halfSpacing),
        ),
        const SettingsOverviewHostHeadersInput(
          padding: EdgeInsetsDirectional.only(top: 4),
        ),
      ],
    );
  }
}

// MARK: dummy pages

@RoutePage()
class ScreenSettingsBehavior extends StatelessWidget {
  const ScreenSettingsBehavior({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("settings behavior"));
  }
}

@RoutePage()
class ScreenSettingsInterface extends StatelessWidget {
  const ScreenSettingsInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("settings interface"));
  }
}

@RoutePage()
class ScreenSettingsVoice extends StatelessWidget {
  const ScreenSettingsVoice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("settings voice"));
  }
}

@RoutePage()
class ScreenSettingsExport extends StatelessWidget {
  const ScreenSettingsExport({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("settings export"));
  }
}

@RoutePage()
class ScreenSettingsAbout extends StatelessWidget {
  const ScreenSettingsAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("settings about"));
  }
}
