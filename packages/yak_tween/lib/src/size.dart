import 'dart:ui';

import 'package:yak_utils/yak_utils.dart';

import '../yak_tween.dart';

/// an `SizeTween` that allows `const` constructor
class YakSizeTween extends YakTween<Size> {
  /// like most `Tween`s has parameters `begin` and `end`
  const YakSizeTween({
    required Size begin,
    required Size end,
  }) : super(begin: begin, end: end); // coverage:ignore-line

  @override
  Size lerp(double t) => Size(
        lerpNNDouble(begin.width, end.width, t),
        lerpNNDouble(begin.height, end.height, t),
      );
}
