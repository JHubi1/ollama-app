import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ListTileSwitchInteractive extends StatelessWidget {
  const ListTileSwitchInteractive({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onTap,
    this.onLongPress,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.thumbColor,
    this.trackColor,
    this.trackOutlineColor,
    this.thumbIcon,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.tileColor,
    this.title,
    this.subtitle,
    this.isThreeLine,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
    this.controlAffinity,
    this.shape,
    this.selectedTileColor,
    this.visualDensity,
    this.enableFeedback,
    this.hoverColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Color? activeThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final WidgetStateProperty<Color?>? thumbColor;
  final WidgetStateProperty<Color?>? trackColor;
  final WidgetStateProperty<Color?>? trackOutlineColor;
  final WidgetStateProperty<Icon?>? thumbIcon;
  final MaterialTapTargetSize? materialTapTargetSize;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;
  final Color? tileColor;
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final bool? isThreeLine;
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
  final bool selected;
  final ListTileControlAffinity? controlAffinity;
  final ShapeBorder? shape;
  final Color? selectedTileColor;
  final VisualDensity? visualDensity;
  final bool? enableFeedback;
  final Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    var listTileTheme = ListTileTheme.of(context);
    var effectiveControlAffinity =
        controlAffinity ??
        listTileTheme.controlAffinity ??
        ListTileControlAffinity.platform;

    var controlChildren = [
      const SizedBox(height: 32, child: VerticalDivider()),
      const SizedBox(width: 8),
      Switch(
        value: value,
        onChanged: onTap != null
            ? onChanged != null
                  ? (value) {
                      Feedback.forTap(context);
                      onChanged!(value);
                    }
                  : null
            : null,
        activeThumbColor: activeThumbColor,
        activeThumbImage: activeThumbImage,
        inactiveThumbImage: inactiveThumbImage,
        materialTapTargetSize:
            materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        autofocus: autofocus,
        onFocusChange: onFocusChange,
        onActiveThumbImageError: onActiveThumbImageError,
        onInactiveThumbImageError: onInactiveThumbImageError,
        thumbColor: thumbColor,
        trackColor: trackColor,
        trackOutlineColor: trackOutlineColor,
        thumbIcon: thumbIcon,
        dragStartBehavior: dragStartBehavior,
        mouseCursor: mouseCursor,
        splashRadius: splashRadius,
        overlayColor: overlayColor,
      ),
    ];
    var control = ExcludeFocus(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: (effectiveControlAffinity == ListTileControlAffinity.leading)
            ? controlChildren.reversed.toList()
            : controlChildren,
      ),
    );

    Widget? leading;
    Widget? trailing;
    (leading, trailing) = switch (effectiveControlAffinity) {
      ListTileControlAffinity.leading => (control, secondary),
      ListTileControlAffinity.trailing ||
      ListTileControlAffinity.platform => (secondary, control),
    };

    var theme = Theme.of(context);
    var switchTheme = SwitchTheme.of(context);
    var states = <WidgetState>{if (selected) WidgetState.selected};
    var effectiveActiveColor =
        activeThumbColor ??
        switchTheme.thumbColor?.resolve(states) ??
        theme.colorScheme.secondary;

    var effectiveContentPadding =
        contentPadding ??
        EdgeInsets.only(
          left: effectiveControlAffinity == ListTileControlAffinity.leading
              ? 16
              : (listTileTheme.contentPadding?.horizontal ?? (16.0 * 2)) / 2,
          right: effectiveControlAffinity != ListTileControlAffinity.leading
              ? 16
              : (listTileTheme.contentPadding?.horizontal ?? (24.0 * 2)) / 2,
        );

    return MergeSemantics(
      child: ListTile(
        selectedColor: effectiveActiveColor,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense,
        contentPadding: effectiveContentPadding,
        enabled: onTap != null,
        onTap: onTap,
        onLongPress: onLongPress,
        selected: selected,
        selectedTileColor: selectedTileColor,
        autofocus: autofocus,
        shape: shape,
        tileColor: tileColor,
        visualDensity: visualDensity,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        enableFeedback: enableFeedback,
        hoverColor: hoverColor,
      ),
    );
  }
}

/// Tis is better than [SwitchListTile] because [contentPadding] is actually
/// set correctly
class ListTileSwitch extends StatelessWidget {
  const ListTileSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.thumbColor,
    this.trackColor,
    this.trackOutlineColor,
    this.thumbIcon,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.tileColor,
    this.title,
    this.subtitle,
    this.isThreeLine,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
    this.controlAffinity,
    this.shape,
    this.selectedTileColor,
    this.visualDensity,
    this.enableFeedback,
    this.hoverColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final WidgetStateProperty<Color?>? thumbColor;
  final WidgetStateProperty<Color?>? trackColor;
  final WidgetStateProperty<Color?>? trackOutlineColor;
  final WidgetStateProperty<Icon?>? thumbIcon;
  final MaterialTapTargetSize? materialTapTargetSize;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;
  final Color? tileColor;
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final bool? isThreeLine;
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
  final bool selected;
  final ListTileControlAffinity? controlAffinity;
  final ShapeBorder? shape;
  final Color? selectedTileColor;
  final VisualDensity? visualDensity;
  final bool? enableFeedback;
  final Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    var listTileTheme = ListTileTheme.of(context);
    var effectiveControlAffinity =
        controlAffinity ??
        listTileTheme.controlAffinity ??
        ListTileControlAffinity.platform;

    var control = ExcludeFocus(
      child: IgnorePointer(
        child: Switch(
          value: value,
          onChanged: (_) {},
          activeThumbColor: activeThumbColor,
          activeThumbImage: activeThumbImage,
          inactiveThumbImage: inactiveThumbImage,
          materialTapTargetSize:
              materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveThumbColor: inactiveThumbColor,
          autofocus: autofocus,
          onFocusChange: onFocusChange,
          onActiveThumbImageError: onActiveThumbImageError,
          onInactiveThumbImageError: onInactiveThumbImageError,
          thumbColor: thumbColor,
          trackColor: trackColor,
          trackOutlineColor: trackOutlineColor,
          thumbIcon: thumbIcon,
          dragStartBehavior: dragStartBehavior,
          mouseCursor: mouseCursor,
          splashRadius: splashRadius,
          overlayColor: overlayColor,
        ),
      ),
    );

    Widget? leading;
    Widget? trailing;
    (leading, trailing) = switch (effectiveControlAffinity) {
      ListTileControlAffinity.leading => (control, secondary),
      ListTileControlAffinity.trailing ||
      ListTileControlAffinity.platform => (secondary, control),
    };

    var theme = Theme.of(context);
    var switchTheme = SwitchTheme.of(context);
    var states = <WidgetState>{if (selected) WidgetState.selected};
    var effectiveActiveColor =
        activeThumbColor ??
        switchTheme.thumbColor?.resolve(states) ??
        theme.colorScheme.secondary;

    var effectiveContentPadding =
        contentPadding ??
        EdgeInsets.only(
          left: effectiveControlAffinity == ListTileControlAffinity.leading
              ? 16
              : (listTileTheme.contentPadding?.horizontal ?? (16.0 * 2)) / 2,
          right: effectiveControlAffinity != ListTileControlAffinity.leading
              ? 16
              : (listTileTheme.contentPadding?.horizontal ?? (16.0 * 2)) / 2,
        );

    return MergeSemantics(
      child: ListTile(
        selectedColor: effectiveActiveColor,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense,
        contentPadding: effectiveContentPadding,
        enabled: onChanged != null,
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        selected: selected,
        selectedTileColor: selectedTileColor,
        autofocus: autofocus,
        shape: shape,
        tileColor: tileColor,
        visualDensity: visualDensity,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        enableFeedback: enableFeedback,
        hoverColor: hoverColor,
      ),
    );
  }
}
