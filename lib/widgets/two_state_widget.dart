import 'package:flutter/material.dart';
import '../services/services.dart';

/// Widget used to blend between two widget states, like icons.
class TwoStateWidget extends StatelessWidget {
  final Animation<double> animation;

  final double? dimension;

  final Widget? from;
  final Widget? to;

  const TwoStateWidget({
    super.key,
    required this.animation,
    this.dimension,
    this.from,
    this.to,
  });

  @override
  Widget build(BuildContext context) {
    final animationFrom = ReverseAnimation(animation);
    final animationTo = animation;

    final children = <Widget>[
      if (from != null) ScaleTransition(scale: animationFrom, child: from),
      if (to != null) ScaleTransition(scale: animationTo, child: to),
    ];
    final child = Stack(
      children: children.map((child) {
        if (dimension != null) return Positioned.fill(child: child);
        return child;
      }).toList(),
    );

    if (dimension != null) {
      return ConstrainedBox(
        constraints: BoxConstraints.tight(Size.square(dimension!)),
        child: child,
      );
    }
    return child;
  }
}

class TwoStateWidgetManaged extends StatefulWidget {
  final bool state;

  final double? dimension;

  final Widget? from;
  final Widget? to;

  final Duration duration;
  final Curve curve;

  TwoStateWidgetManaged({
    super.key,
    required this.state,
    this.dimension,
    this.from,
    this.to,
    Duration? duration,
    Curve? curve,
  }) : duration = duration ?? ExpressiveCurves.expressiveSpatial.fastDuration,
       curve = curve ?? ExpressiveCurves.expressiveSpatial.fast;

  @override
  State<TwoStateWidgetManaged> createState() => _TwoStateWidgetManagedState();
}

class _TwoStateWidgetManagedState extends State<TwoStateWidgetManaged>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.state ? 1.0 : 0.0,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(covariant TwoStateWidgetManaged oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      );
    }

    if (widget.state != oldWidget.state) {
      if (widget.state) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TwoStateWidget(
    animation: _animation!,
    dimension: widget.dimension,
    from: widget.from,
    to: widget.to,
  );
}
