import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget that implements the Material Design alert dialog layout structure.
///
/// The handling is identical to [AlertDialog], but instead of returning a
/// [Dialog], it returns a [Widget] that can be used as a child of a [Dialog]:
///
/// ```dart
/// Dialog(
///     semanticsRole: SemanticsRole.alertDialog,
///     child: AlertDialogChild(...),
/// );
/// ```
///
/// The code above would be equivalent to using [AlertDialog] directly.
/// Dialog-level properties ([backgroundColor], [elevation], [shadowColor],
/// [surfaceTintColor], [insetPadding], [clipBehavior], [shape], [alignment],
/// [constraints]) are not accepted by this widget and must be passed directly
/// to the [Dialog] wrapper instead.
class AlertDialogChild extends StatelessWidget {
  const AlertDialogChild({
    super.key,
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.semanticLabel,
    this.scrollable = false,
  });

  final Widget? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final Widget? title;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleTextStyle;
  final Widget? content;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentTextStyle;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  final MainAxisAlignment? actionsAlignment;
  final OverflowBarAlignment? actionsOverflowAlignment;
  final VerticalDirection? actionsOverflowDirection;
  final double? actionsOverflowButtonSpacing;
  final EdgeInsetsGeometry? buttonPadding;
  final String? semanticLabel;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    assert(
      debugCheckHasMaterialLocalizations(context),
      "No MaterialLocalizations found.",
    );
    final theme = Theme.of(context);

    final dialogTheme = DialogTheme.of(context);
    final defaults = theme.useMaterial3
        ? _DialogDefaultsM3(context)
        : _DialogDefaultsM2(context);

    final label = switch (defaultTargetPlatform) {
      TargetPlatform.iOS || TargetPlatform.macOS => semanticLabel,
      TargetPlatform.android ||
      TargetPlatform.fuchsia ||
      TargetPlatform.linux ||
      TargetPlatform.windows =>
        semanticLabel ?? MaterialLocalizations.of(context).alertDialogLabel,
    };

    // The paddingScaleFactor is used to adjust the padding of Dialog's
    // children.
    const fontSizeToScale = 14.0;
    final effectiveTextScale =
        MediaQuery.textScalerOf(context).scale(fontSizeToScale) /
        fontSizeToScale;
    final paddingScaleFactor = _scalePadding(effectiveTextScale);
    final textDirection = Directionality.maybeOf(context);

    Widget? iconWidget;
    Widget? titleWidget;
    Widget? contentWidget;
    Widget? actionsWidget;

    if (icon != null) {
      final belowIsTitle = title != null;
      final belowIsContent = !belowIsTitle && content != null;
      final defaultIconPadding = EdgeInsets.only(
        left: 24.0,
        top: 24.0,
        right: 24.0,
        bottom: belowIsTitle
            ? 16.0
            : belowIsContent
            ? 0.0
            : 24.0,
      );
      final effectiveIconPadding =
          iconPadding?.resolve(textDirection) ?? defaultIconPadding;
      iconWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveIconPadding.left * paddingScaleFactor,
          right: effectiveIconPadding.right * paddingScaleFactor,
          top: effectiveIconPadding.top * paddingScaleFactor,
          bottom: effectiveIconPadding.bottom,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor ?? dialogTheme.iconColor ?? defaults.iconColor,
          ),
          child: icon!,
        ),
      );
    }

    if (title != null) {
      final defaultTitlePadding = EdgeInsets.only(
        left: 24.0,
        top: icon == null ? 24.0 : 0.0,
        right: 24.0,
        bottom: content == null ? 20.0 : 0.0,
      );
      final effectiveTitlePadding =
          titlePadding?.resolve(textDirection) ?? defaultTitlePadding;
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: icon == null
              ? effectiveTitlePadding.top * paddingScaleFactor
              : effectiveTitlePadding.top,
          bottom: effectiveTitlePadding.bottom,
        ),
        child: DefaultTextStyle(
          style:
              titleTextStyle ??
              dialogTheme.titleTextStyle ??
              defaults.titleTextStyle!,
          textAlign: icon == null ? TextAlign.start : TextAlign.center,
          child: Semantics(
            // For iOS platform, the focus always lands on the title.
            // Set nameRoute to false to avoid title being announce twice.
            namesRoute:
                label == null && defaultTargetPlatform != TargetPlatform.iOS,
            container: true,
            child: title,
          ),
        ),
      );
    }

    if (content != null) {
      final defaultContentPadding = EdgeInsets.only(
        left: 24.0,
        top: theme.useMaterial3 ? 16.0 : 20.0,
        right: 24.0,
        bottom: 24.0,
      );
      final effectiveContentPadding =
          contentPadding?.resolve(textDirection) ?? defaultContentPadding;
      contentWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left * paddingScaleFactor,
          right: effectiveContentPadding.right * paddingScaleFactor,
          top: title == null && icon == null
              ? effectiveContentPadding.top * paddingScaleFactor
              : effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        child: DefaultTextStyle(
          style:
              contentTextStyle ??
              dialogTheme.contentTextStyle ??
              defaults.contentTextStyle!,
          child: Semantics(
            container: true,
            explicitChildNodes: true,
            child: content,
          ),
        ),
      );
    }

    if (actions != null) {
      final spacing = (buttonPadding?.horizontal ?? 16) / 2;
      actionsWidget = Padding(
        padding:
            actionsPadding ??
            dialogTheme.actionsPadding ??
            (theme.useMaterial3
                ? defaults.actionsPadding!
                : defaults.actionsPadding!.add(EdgeInsets.all(spacing))),
        child: OverflowBar(
          alignment: actionsAlignment ?? MainAxisAlignment.end,
          spacing: spacing,
          overflowAlignment:
              actionsOverflowAlignment ?? OverflowBarAlignment.end,
          overflowDirection: actionsOverflowDirection ?? VerticalDirection.down,
          overflowSpacing: actionsOverflowButtonSpacing ?? 0,
          children: actions!,
        ),
      );
    }

    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (title != null || content != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[?iconWidget, ?titleWidget, ?contentWidget],
              ),
            ),
          ),
        ?actionsWidget,
      ];
    } else {
      columnChildren = <Widget>[
        ?iconWidget,
        ?titleWidget,
        if (contentWidget != null) Flexible(child: contentWidget),
        ?actionsWidget,
      ];
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return dialogChild;
  }
}

class _DialogDefaultsM2 extends DialogThemeData {
  _DialogDefaultsM2(this.context)
    : super(
        alignment: Alignment.center,
        elevation: 24.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        clipBehavior: Clip.none,
      );

  final BuildContext context;
  late final ThemeData theme = Theme.of(context);
  late final TextTheme textTheme = theme.textTheme;
  late final IconThemeData iconTheme = theme.iconTheme;

  @override
  Color? get iconColor => iconTheme.color;

  @override
  Color? get backgroundColor =>
      theme.brightness == Brightness.dark ? Colors.grey[800]! : Colors.white;

  @override
  Color? get shadowColor => theme.shadowColor;

  @override
  TextStyle? get titleTextStyle => textTheme.titleLarge;

  @override
  TextStyle? get contentTextStyle => textTheme.titleMedium;

  @override
  EdgeInsetsGeometry? get actionsPadding => EdgeInsets.zero;
}

class _DialogDefaultsM3 extends DialogThemeData {
  _DialogDefaultsM3(this.context)
    : super(
        alignment: Alignment.center,
        elevation: 6.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
        ),
        clipBehavior: Clip.none,
      );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  Color? get iconColor => _colors.secondary;

  @override
  Color? get backgroundColor => _colors.surfaceContainerHigh;

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  TextStyle? get titleTextStyle => _textTheme.headlineSmall;

  @override
  TextStyle? get contentTextStyle => _textTheme.bodyMedium;

  @override
  EdgeInsetsGeometry? get actionsPadding =>
      const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0);
}

double _scalePadding(double textScaleFactor) {
  final clampedTextScaleFactor = clampDouble(textScaleFactor, 1.0, 2.0);
  return lerpDouble(1.0, 1.0 / 3.0, clampedTextScaleFactor - 1.0)!;
}
