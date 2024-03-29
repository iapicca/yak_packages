import 'package:flutter/foundation.dart';
import '../yak_tween.dart';

/// an `ConstantTween` that allows `const` constructor
class YakConstantTween<T> extends YakTween<T> {
  /// has a parameter `value`
  const YakConstantTween(T value)
      : super(begin: value, end: value); // coverage:ignore-line

  @override
  T lerp(double t) => begin;

  @override
  String toString() =>
      '${objectRuntimeType(this, 'YakConstantTween')}(value: $begin)';
}
