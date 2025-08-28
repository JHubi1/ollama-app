import 'package:flutter/material.dart';

class ListTileSlide extends StatelessWidget {
  const ListTileSlide({
    super.key,
    required this.value,
    this.secondaryTrackValue,
    this.onChanged,
    this.valueMin,
    this.valueMax,
    this.divisions,
    this.thumbColor,
    this.overlayColor,
    this.mouseCursor,
    this.focusNode,
    this.allowedInteraction,
    this.autofocus = false,
    this.leading,
    this.trailing,
    this.tileColor,
    this.title,
    this.subtitle,
    this.secondary,
    this.isThreeLine,
    this.dense = false,
    this.contentPadding,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.shape,
    this.selectedTileColor,
    this.visualDensity,
    this.enableFeedback,
  });

  final double value;
  final double? secondaryTrackValue;
  final ValueChanged<double>? onChanged;
  final double? valueMin;
  final double? valueMax;
  final int? divisions;
  final Color? thumbColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final SliderInteraction? allowedInteraction;
  final bool autofocus;
  final Widget? leading;
  final Widget? trailing;
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

  @override
  Widget build(BuildContext context) {
    var content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subtitle != null) subtitle!,
        Slider(
          value: value,
          secondaryTrackValue: (value / (valueMax ?? 1.0)) < 0.98
              ? secondaryTrackValue
              : 0,
          onChanged: onChanged,
          min: valueMin ?? 0.0,
          max: valueMax ?? 1.0,
          divisions: divisions,
          thumbColor: thumbColor,
          overlayColor: overlayColor,
          mouseCursor: mouseCursor,
          focusNode: focusNode,
          autofocus: autofocus,
          allowedInteraction: allowedInteraction,
          padding: EdgeInsets.zero,
        ),
      ],
    );

    var theme = Theme.of(context);
    var switchTheme = SliderTheme.of(context);
    var effectiveActiveColor =
        thumbColor ?? switchTheme.thumbColor ?? theme.colorScheme.secondary;

    return MergeSemantics(
      child: ListTile(
        selectedColor: effectiveActiveColor,
        leading: leading,
        title: title,
        subtitle: content,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense,
        contentPadding: contentPadding,
        enabled: onChanged != null,
        selected: selected,
        selectedTileColor: selectedTileColor,
        autofocus: autofocus,
        shape: shape,
        tileColor: tileColor,
        visualDensity: visualDensity,
      ),
    );
  }
}
