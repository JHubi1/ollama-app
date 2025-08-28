import 'dart:async';

import 'package:flutter/material.dart';

Widget? _defaultListTileSetterTitle(dynamic value) {
  try {
    return Text("Value of type ${value.runtimeType.toString().trim()}");
  } catch (e) {
    return null;
  }
}

Widget? _defaultListTileSetterSubtitleBuilder(dynamic value) {
  try {
    return Text(value.toString());
  } catch (e) {
    return null;
  }
}

class ListTileSetter<T extends Object> extends StatefulWidget {
  final T initialValue;
  final ValueChanged<T>? onChanged;
  final FutureOr<T> Function(T oldValue) action;

  final Widget? leading;
  final Widget? Function(T value)? titleBuilder;
  final Widget? Function(T value)? subtitleBuilder;
  final Widget? trailing;
  final bool? isThreeLine;
  final bool? dense;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final ListTileStyle? style;
  final Color? selectedColor;
  final Color? iconColor;
  final Color? textColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final TextStyle? leadingAndTrailingTextStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final ValueChanged<bool>? onFocusChange;
  final MouseCursor? mouseCursor;
  final bool Function(T value)? selected;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? tileColor;
  final Color? selectedTileColor;
  final bool? enableFeedback;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final double? minTileHeight;
  final ListTileTitleAlignment? titleAlignment;

  const ListTileSetter({
    super.key,
    required this.initialValue,
    this.onChanged,
    required this.action,

    this.leading,
    this.titleBuilder = _defaultListTileSetterTitle,
    this.subtitleBuilder = _defaultListTileSetterSubtitleBuilder,
    this.trailing,

    this.isThreeLine,
    this.dense,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.contentPadding,
    this.enabled = true,
    this.onFocusChange,
    this.mouseCursor,
    this.selected,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.minTileHeight,
    this.titleAlignment,
  });

  @override
  State<ListTileSetter<T>> createState() => _ListTileSetterState();
}

class _ListTileSetterState<T extends Object> extends State<ListTileSetter<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading,
      title: widget.titleBuilder?.call(value),
      subtitle: widget.subtitleBuilder?.call(value),
      trailing: widget.trailing,
      isThreeLine: widget.isThreeLine,
      dense: widget.dense,
      visualDensity: widget.visualDensity,
      shape: widget.shape,
      style: widget.style,
      selectedColor: widget.selectedColor,
      iconColor: widget.iconColor,
      textColor: widget.textColor,
      titleTextStyle: widget.titleTextStyle,
      subtitleTextStyle: widget.subtitleTextStyle,
      leadingAndTrailingTextStyle: widget.leadingAndTrailingTextStyle,
      contentPadding: widget.contentPadding,
      enabled: widget.enabled,
      onFocusChange: widget.onFocusChange,
      mouseCursor: widget.mouseCursor,
      selected: widget.selected?.call(value) ?? false,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      splashColor: widget.splashColor,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      tileColor: widget.tileColor,
      selectedTileColor: widget.selectedTileColor,
      enableFeedback: widget.enableFeedback,
      horizontalTitleGap: widget.horizontalTitleGap,
      minVerticalPadding: widget.minVerticalPadding,
      minLeadingWidth: widget.minLeadingWidth,
      minTileHeight: widget.minTileHeight,
      titleAlignment: widget.titleAlignment,
      onTap: () async {
        value = await widget.action(value);
        if (widget.onChanged != null) widget.onChanged!.call(value);

        if (!mounted || !context.mounted) return;
        setState(() {});
        FocusScope.of(context).requestFocus(widget.focusNode);
      },
    );
  }
}
