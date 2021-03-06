import 'dart:ui';

import 'package:yak_utils/yak_utils.dart';

import '../yak_tween.dart';

/// an `ColorTween` that allows `const` constructor

class YakColorTween extends YakTween<Color> {
  /// like most `Tween`s has parameters `begin` and `end`
  const YakColorTween({
    required Color begin,
    required Color end,
  }) : super(begin: begin, end: end); // coverage:ignore-line

  @override
  Color lerp(double t) => Color.fromARGB(
        clampInt(lerpInt(begin.alpha, end.alpha, t).toInt(), 0, 255),
        clampInt(lerpInt(begin.red, end.red, t).toInt(), 0, 255),
        clampInt(lerpInt(begin.green, end.green, t).toInt(), 0, 255),
        clampInt(lerpInt(begin.blue, end.blue, t).toInt(), 0, 255),
      );
}
