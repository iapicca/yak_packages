import 'package:flutter/painting.dart';
import 'tween.dart';

/// an `BorderTwee` that allows `const` constructor

class YakBorderTween extends YakTween<Border> {
  /// like most `Tween`s has parameters `begin` and `end`
  const YakBorderTween({
    required Border begin,
    required Border end,
  })
  // coverage:ignore-line
  : super(
          begin: begin,
          end: end,
        );
  @override
  Border lerp(double t) => Border(
        top: BorderSide.lerp(begin.top, end.top, t),
        right: BorderSide.lerp(begin.right, end.right, t),
        bottom: BorderSide.lerp(begin.bottom, end.bottom, t),
        left: BorderSide.lerp(begin.left, end.left, t),
      );
}
