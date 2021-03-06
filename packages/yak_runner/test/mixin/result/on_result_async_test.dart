import 'dart:async';

import 'package:stub/stub.dart';
import 'package:test/test.dart';
import 'package:yak_error_handler/yak_error_handler.dart';
import 'package:yak_runner/yak_runner.dart';

void main() {
  const data = 1;
  final reportStub = unaryStub<void, ErrorReport>()..stub = (_) {};
  group('`onResultAsync` MIXIN', () {
    final firstDelegate = nullaryStub<int>();
    final secondDelegate = unaryStub<Future<String>, FutureOr<int>>();

    final firstRunner = Runner<int>(
      firstDelegate.wrap,
      errorReport: reportStub.wrap,
    );
    final secondRunner = UnaryRunnerAsync<String, int>(
      secondDelegate.wrap,
      errorReport: reportStub.wrap,
    );

    test('WHEN `Delegate<S>` fails THEN  `onResult() return Failure<T>',
        () async {
      reportStub.reset;
      firstDelegate.reset;
      secondDelegate.reset;

      firstDelegate.stub = () => throw Exception();
      secondDelegate.stub = (i) async => '$i';
      final result = await firstRunner().onFutureResult<String>(secondRunner);

      expect(
        result,
        isNotNull,
        reason: '`result` must not be null',
      );
      expect(
        result,
        isNot(Success),
        reason: '`result` should not be `Success`',
      );
      expect(
        result is Failure<int>,
        false,
        reason: '`result`should not be `Failure<S>`',
      );
      expect(
        result,
        isA<Failure<String>>(),
        reason: '`result` should be `Failure<T>`',
      );
      expect(
        firstDelegate.count,
        1,
        reason: '`firstDelegate` should be called once',
      );
      expect(
        secondDelegate.count,
        0,
        reason: '`secondDelegate` should NOT be called',
      );
      expect(
        reportStub.count,
        1,
        reason: '`errorReport` shoul be called once',
      );
    });

    test(
        'WHEN `ArgDelegate<Future<T>,FutureOr<S>>` fail '
        'THEN  `onResult() return Failure<T>', () async {
      reportStub.reset;
      firstDelegate.reset;
      secondDelegate.reset;

      firstDelegate.stub = () => data;
      secondDelegate.stub = (i) => throw Exception();

      final result = await firstRunner().onFutureResult<String>(secondRunner);

      expect(
        result,
        isNotNull,
        reason: '`result` must not be null',
      );
      expect(
        result,
        isNot(Success),
        reason: '`result` should not be `Success`',
      );
      expect(
        result is Failure<int>,
        false,
        reason: '`result`should not be `Failure<S>`',
      );
      expect(
        result,
        isA<Failure<String>>(),
        reason: '`result` should be `Failure<T>`',
      );
      expect(
        firstDelegate.count,
        1,
        reason: '`firstDelegate` should be called once',
      );
      expect(
        secondDelegate.count,
        1,
        reason: '`secondDelegate` should NOT be called',
      );
      expect(
        reportStub.count,
        1,
        reason: '`errorReport` shoul be called once',
      );
    });

    test(
        'WHEN `ArgDelegate<Future<T>,FutureOr<S>>` does not fail '
        'THEN  `onResult() return Success<T>', () async {
      reportStub.reset;
      firstDelegate.reset;
      secondDelegate.reset;

      firstDelegate.stub = () => data;
      secondDelegate.stub = (i) async => '$i';

      final result = await firstRunner().onFutureResult<String>(secondRunner);

      expect(
        result,
        isNotNull,
        reason: '`result` must not be null',
      );
      expect(
        result,
        isA<Success>(),
        reason: '`result` should be `Success`',
      );

      expect(
        result,
        isNot(Failure),
        reason: '`result` should not be `Failure`',
      );
      expect(
        firstDelegate.count,
        1,
        reason: '`firstDelegate` should be called once',
      );
      expect(
        secondDelegate.count,
        1,
        reason: '`secondDelegate` should NOT be called',
      );
      expect(
        reportStub.count,
        0,
        reason: '`errorReport` shoul NOT be called',
      );
    });
  });
}
