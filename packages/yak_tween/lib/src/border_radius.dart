import 'package:flutter/painting.dart';
import '../yak_tween.dart';

/// an `BorderRadiusTween` that allows `const` constructor

class YakBorderRadiusTween extends YakTween<BorderRadius> {
  /// like most `Tween`s has parameters `begin` and `end`
  const YakBorderRadiusTween({required super.begin, required super.end});

  @override
  BorderRadius lerp(double t) => BorderRadius.only(
        topLeft: radiusNNLerp(begin.topLeft, end.topLeft, t),
        topRight: radiusNNLerp(begin.topRight, end.topRight, t),
        bottomLeft: radiusNNLerp(begin.bottomLeft, end.bottomLeft, t),
        bottomRight: radiusNNLerp(begin.bottomRight, end.bottomRight, t),
      );
}
