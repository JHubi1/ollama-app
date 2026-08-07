import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MeasureSize extends SingleChildRenderObjectWidget {
  final void Function(Size size) onChange;
  const MeasureSize({super.key, required this.onChange, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      MeasureSizeRenderObject(onChange);

  @override
  void updateRenderObject(
    BuildContext context,
    MeasureSizeRenderObject renderObject,
  ) => renderObject.onChange = onChange;
}

class MeasureSizeRenderObject extends RenderProxyBox {
  ValueChanged<Size> onChange;
  Size? _oldSize;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();
    final newSize = child?.size ?? Size.zero;

    if (_oldSize != newSize) {
      _oldSize = newSize;
      WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
    }
  }
}
