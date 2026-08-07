import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart' as intl;

import '../l10n/gen/app_localizations.dart';
import '../services/services.dart';
import '../util/extensions.dart';
import 'model_adder.dart';
import 'sized_circular_progress_indicator.dart';
import 'two_state_widget.dart';

// MARK: Model Selector Dialog

class _ModelSelectorDialog extends StatelessWidget {
  final GlobalKey? anchorKey;

  const _ModelSelectorDialog({this.anchorKey});

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    final embeddedNavigation = breakpoint.panesRecommended >= 2;
    if (!embeddedNavigation) {
      return const Dialog.fullscreen(
        child: ModelSelector(embeddedNavigation: false),
      );
    }

    var anchorRect = Rect.zero;
    final renderBox = anchorKey?.currentContext?.findRenderObject();
    if (renderBox is RenderBox) {
      anchorRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    }

    final screenSize = MediaQuery.sizeOf(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    const minWidth = 280.0;
    const maxWidth = 560.0;
    const edgeGap = 24.0;

    final anchorEdge = isRtl
        ? screenSize.width - anchorRect.right
        : anchorRect.left;
    final position = anchorEdge
        .clamp(0.0, max(0.0, screenSize.width - maxWidth))
        .toDouble();
    final effectiveMaxWidth = (screenSize.width - position - edgeGap).clamp(
      minWidth,
      maxWidth,
    );
    final top = anchorRect.bottom - 24;

    final popup = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: effectiveMaxWidth,
        maxHeight: screenSize.height - top - edgeGap,
      ),
      child: Material(
        type: MaterialType.card,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: const ModelSelector(embeddedNavigation: true),
      ),
    );

    return Stack(
      children: [
        if (isRtl)
          Positioned(right: position, top: top, child: popup)
        else
          Positioned(left: position, top: top, child: popup),
      ],
    );
  }
}

Future<void> showModelSelector({
  required BuildContext context,
  required GlobalKey? anchorKey,
}) => showDialog(
  context: context,
  barrierDismissible: true,
  barrierColor: Colors.transparent,
  builder: (context) => _ModelSelectorDialog(anchorKey: anchorKey),
);

// MARK: Model Selector

class ModelSelector extends StatefulWidget {
  final bool embeddedNavigation;
  const ModelSelector({super.key, required this.embeddedNavigation});

  @override
  State<ModelSelector> createState() => _ModelSelectorState();
}

class _ModelSelectorState extends State<ModelSelector> {
  @override
  void initState() {
    super.initState();
    ModelManager.instance.addListener(onUpdate);
  }

  @override
  void dispose() {
    ModelManager.instance.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModelSelectorHeader(embeddedNavigation: widget.embeddedNavigation),
          ...ModelManager.instance.models.map((model) {
            final tmp = ModelSelectorTile(
              model: model,
              onTap: () {
                ModelManager.instance.currentModel = model;
                Navigator.of(context).pop();
              },
            );
            if (widget.embeddedNavigation) {
              return tmp;
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: breakpoint.spacing / 2,
                ),
                child: tmp,
              );
            }
          }),
        ],
      ),
    );
  }
}

class ModelSelectorHeader extends StatefulWidget {
  final bool embeddedNavigation;
  const ModelSelectorHeader({super.key, required this.embeddedNavigation});

  @override
  State<ModelSelectorHeader> createState() => _ModelSelectorHeaderState();
}

class _ModelSelectorHeaderState extends State<ModelSelectorHeader> {
  bool _isLoading = false;
  bool _loadingFromAdd = false;

  Future<void> refreshModels() async {
    if (_isLoading) return;
    if (HostManager.instance.host == null) {
      Navigator.of(context).pop();
    }

    _isLoading = true;
    if (mounted) setState(() {});

    if (mounted) {
      await errorGuard(context, "N3AI17J1", () async {
        try {
          await Future.wait([
            ModelManager.instance.loadModels(),
            Future.delayed(Durations.long1),
          ]).catchError(Error.throwWithStackTrace);
        } finally {
          _isLoading = false;
          _loadingFromAdd = false;
          if (mounted) setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final textTheme = TextTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final title = Text(
      appLocalizations.modelDialogTitle,
      style: widget.embeddedNavigation ? textTheme.titleMedium : null,
    );
    final actions = [
      TwoStateWidgetManaged(
        state: _isLoading && _loadingFromAdd,
        dimension: (iconTheme.size ?? 24) + (8 * 2),
        from: IconButton(
          icon: const Icon(Icons.add),
          tooltip: appLocalizations.modelDialogAdd,
          onPressed: !_isLoading
              ? () async {
                  final addedModel = await showModelAdderDialog(context);
                  if (addedModel != null) {
                    ModelManager.instance.currentModelName = addedModel;
                    if (!context.mounted) return;
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          appLocalizations.modelDialogAddDownloadSuccess,
                        ),
                      ),
                    );
                  }
                }
              : null,
        ),
        to: const AspectRatio(
          aspectRatio: 1 / 1,
          child: SizedBox.expand(
            child: Center(
              child: SizedCircularProgressIndicator(
                dimension: 24,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.only(
          end: widget.embeddedNavigation ? 0 : 8,
        ),
        child: TwoStateWidgetManaged(
          state: _isLoading && !_loadingFromAdd,
          dimension: (iconTheme.size ?? 24) + (8 * 2),
          from: IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: appLocalizations.modelDialogRefresh,
            onPressed: !_isLoading ? refreshModels : null,
          ),
          to: const AspectRatio(
            aspectRatio: 1 / 1,
            child: SizedBox.expand(
              child: Center(
                child: SizedCircularProgressIndicator(
                  dimension: 24,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    ];

    return widget.embeddedNavigation
        ? Row(mainAxisAlignment: MainAxisAlignment.end, children: actions)
        : AppBar(
            leading: const AspectRatio(
              aspectRatio: 1 / 1,
              child: SizedBox.expand(child: BackButton()),
            ),
            title: title,
            actions: actions,
          );
  }
}

class ModelSelectorTile extends StatelessWidget {
  final Model model;
  final VoidCallback? onTap;

  const ModelSelectorTile({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconTheme = IconTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final Widget subtitle = Builder(
      builder: (context) => Wrap(
        children: [
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0, -1),
                    child: Icon(
                      Icons.functions,
                      size: DefaultTextStyle.of(context).style.fontSize,
                    ),
                  ),
                ),
                const TextSpan(text: " "),
                TextSpan(
                  text: model.parameterSize.replaceAll(
                    ".",
                    intl.NumberFormat.decimalPattern(
                      appLocalizations.localeName,
                    ).symbols.DECIMAL_SEP,
                  ),
                ),
              ],
            ),
          ),
          Text(" " * 3),
          if ((model.families.isEmpty ? [model.family] : model.families)
                      .length !=
                  1 ||
              (model.families.isEmpty ? [model.family] : model.families)
                      .first !=
                  model.name.split(":").first) ...[
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, -1),
                      child: Icon(
                        Icons.group,
                        size: DefaultTextStyle.of(context).style.fontSize,
                      ),
                    ),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(
                    children:
                        (model.families.isEmpty
                                ? [model.family]
                                : model.families)
                            .map((family) => TextSpan(text: family))
                            .joinElements(const TextSpan(text: ", "))
                            .toList(),
                  ),
                ],
              ),
            ),
            Text(" " * 3),
          ],
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0, -1),
                    child: Icon(
                      Icons.sd_storage_outlined,
                      size: DefaultTextStyle.of(context).style.fontSize,
                    ),
                  ),
                ),
                const TextSpan(text: " "),
                TextSpan(
                  text: bytesToHumanReadable(
                    model.size,
                    locale: appLocalizations.localeName,
                  ),
                ),
              ],
            ),
          ),
          Text(" " * 3),
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0, -1),
                    child: Icon(
                      Icons.calendar_today,
                      size: DefaultTextStyle.of(context).style.fontSize,
                    ),
                  ),
                ),
                const TextSpan(text: " "),
                TextSpan(
                  text: GetTimeAgo.parse(
                    model.modifiedAt,
                    locale: appLocalizations.localeName,
                    pattern: intl.DateFormat.yMd(
                      appLocalizations.localeName,
                    ).pattern,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final tmp = ListTile(
      title: Builder(
        builder: (context) => Text.rich(
          TextSpan(children: model.nameColored(context)),
          style: DefaultTextStyle.of(
            context,
          ).style.copyWith(fontFamily: "GoogleSansCode"),
        ),
      ),
      subtitle: subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: model.capabilities
            .map(
              (capability) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 2),
                child: Tooltip(
                  message: capability.name.toTitleCase(),
                  child: Icon(
                    capability.icon,
                    size: (iconTheme.size ?? 24) - ((iconTheme.size ?? 24) / 3),
                  ),
                ),
              ),
            )
            .toList(),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );

    return AnimatedContainer(
      duration: ExpressiveCurves.expressiveEffects.fastDuration,
      curve: ExpressiveCurves.expressiveEffects.fast,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: ModelManager.instance.currentModel == model
            ? Border.all(color: colorScheme.outline, width: 2)
            : Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0),
                width: 2,
              ),
      ),
      child: tmp,
    );
  }
}
