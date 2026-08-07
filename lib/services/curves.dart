import 'package:flutter/animation.dart';

typedef CurveGroup = ({
  Curve fast,
  Duration fastDuration,
  Curve normal,
  Duration normalDuration,
  Curve slow,
  Duration slowDuration,
});

final class ExpressiveCurves {
  ExpressiveCurves._();

  static const CurveGroup expressiveSpatial = (
    fast: Cubic(0.42, 1.67, 0.21, 0.90),
    fastDuration: Duration(milliseconds: 350),
    normal: Cubic(0.38, 1.21, 0.22, 1.00),
    normalDuration: Duration(milliseconds: 500),
    slow: Cubic(0.39, 1.29, 0.35, 0.98),
    slowDuration: Duration(milliseconds: 650),
  );

  static const CurveGroup expressiveEffects = (
    fast: Cubic(0.31, 0.94, 0.34, 1.00),
    fastDuration: Duration(milliseconds: 150),
    normal: Cubic(0.34, 0.80, 0.34, 1.00),
    normalDuration: Duration(milliseconds: 200),
    slow: Cubic(0.34, 0.88, 0.34, 1.00),
    slowDuration: Duration(milliseconds: 300),
  );

  static const CurveGroup standardSpatial = (
    fast: Cubic(0.27, 1.06, 0.18, 1.00),
    fastDuration: Duration(milliseconds: 350),
    normal: Cubic(0.27, 1.06, 0.18, 1.00),
    normalDuration: Duration(milliseconds: 500),
    slow: Cubic(0.27, 1.06, 0.18, 1.00),
    slowDuration: Duration(milliseconds: 750),
  );

  static const CurveGroup standardEffects = (
    fast: Cubic(0.31, 0.94, 0.34, 1.00),
    fastDuration: Duration(milliseconds: 150),
    normal: Cubic(0.34, 0.80, 0.34, 1.00),
    normalDuration: Duration(milliseconds: 200),
    slow: Cubic(0.34, 0.88, 0.34, 1.00),
    slowDuration: Duration(milliseconds: 300),
  );
}
