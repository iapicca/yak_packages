import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:yak_tween/yak_tween.dart';

void main() {
  group('`YakCurveTween` test', () {
    const value = Curves.bounceIn;
    const object = YakCurveTween(curve: value);
    test(
        'WHEN `YakCurveTween` and `CurveTween` transform '
        'THEN output is identical', () {
      const lerp = 1 / 3;
      final tween = CurveTween(curve: value);
      expect(
        object.transform(lerp),
        tween.transform(lerp),
        reason: '`YakCurveTween` & `CurveTween` transform the same output',
      );
    });
    test('`toString` works as intended', () {
      const argumentName = 'curve: ';
      const objectName = 'YakCurveTween';
      final match = '$objectName($argumentName$value)';
      expect(
        '$object',
        match,
        reason: '`toString` output must be predictable',
      );
    });
  });
}
