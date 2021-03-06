import 'dart:ui';
import '../../yak_math.dart';

/// an `SizeTween` that allows `const` constructor
class YakSizeTween extends YakTween<Size> {
  /// like most `Tween`s has parameters `begin` and `end`
  const YakSizeTween({
    required Size begin,
    required Size end,
  })
  // coverage:ignore-line
  : super(
          begin: begin,
          end: end,
        );
  @override
  Size lerp(double t) => Size(
        lerpNNDouble(begin.width, end.width, t),
        lerpNNDouble(begin.height, end.height, t),
      );
}
