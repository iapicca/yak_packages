import 'package:flutter/painting.dart';
import 'package:yak_utils/yak_utils.dart';

import '../yak_tween.dart';

/// an `AlignmentTween` that allows `const` constructor

class YakAlignmentTween extends YakTween<Alignment> {
  /// like most `Tween`s has parameters `begin` and `end`
  const YakAlignmentTween({
    required Alignment begin,
    required Alignment end,
  }) : super(begin: begin, end: end); // coverage:ignore-line

  @override
  Alignment lerp(double t) => Alignment(
        lerpNNDouble(begin.x, end.x, t),
        lerpNNDouble(begin.y, end.y, t),
      );
}
