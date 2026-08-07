import 'package:flutter/material.dart';

class SizedCircularProgressIndicator extends StatelessWidget {
  final double? dimension;
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double? strokeWidth;
  final double? strokeAlign;
  final StrokeCap? strokeCap;
  final BoxConstraints? constraints;
  final double? trackGap;

  @Deprecated(
    'Set this flag to false to opt into the 2024 progress indicator appearance. Defaults to true. '
    'In the future, this flag will default to false. Use ProgressIndicatorThemeData to customize individual properties. '
    'This feature was deprecated after v3.27.0-0.2.pre.',
  )
  final bool? year2023;
  final EdgeInsetsGeometry? padding;
  final AnimationController? controller;

  const SizedCircularProgressIndicator({
    super.key,
    this.value,
    this.dimension,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth,
    this.strokeAlign,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeCap,
    this.constraints,
    this.trackGap,
    @Deprecated(
      'Set this flag to false to opt into the 2024 progress indicator appearance. Defaults to true. '
      'In the future, this flag will default to false. Use ProgressIndicatorThemeData to customize individual properties. '
      'This feature was deprecated after v3.27.0-0.1.pre.',
    )
    this.year2023,
    this.padding,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final scale = (dimension ?? 40) / 40;

    final indicator = CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      color: color,
      valueColor: valueColor,
      strokeWidth: (strokeWidth ?? 4) / scale,
      strokeAlign: strokeAlign,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeCap: strokeCap,
      constraints: constraints,
      trackGap: trackGap,
      // pipe through
      // ignore: deprecated_member_use
      year2023: year2023,
      padding: padding,
      controller: controller,
    );
    if (scale == 1) return indicator;

    return Transform.scale(scale: scale, child: indicator);
  }
}
