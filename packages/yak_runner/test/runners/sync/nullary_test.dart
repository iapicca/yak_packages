import 'package:test/test.dart';
import 'package:yak_runner/yak_runner.dart';
import '../../mocks/all.dart';
//  ignore_for_file: avoid_catching_errors

void main() {
  const data = 1;

  group('`YakRunner`', () {
    final exceptionHandler = MockExceptionHandler();
    final delegate = MockDelegate<int>();
    final errorHandler = MockHandleError<AssertionError>();
    final runner = YakRunner(
      delegate,
      handleException: exceptionHandler,
      errorsWhitelist: {errorHandler},
    );

    test('WHEN `void Function()` throws THEN `Result` is `Failure`', () {
      delegate.reset;
      exceptionHandler.reset;
      errorHandler.reset;

      delegate.result = () => throw Exception();
      exceptionHandler.result = () {};
      errorHandler.result = () {};

      final result = runner();

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
        result,
        isA<Failure>(),
        reason: '`result` should be `Failure`',
      );
      expect(
        delegate.callCount,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        exceptionHandler.callCount,
        1,
        reason: '`exceptionHandler` should be called once',
      );
      expect(
        errorHandler.callCount,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });

    test('WHEN `void Function()` does not fail `Result` is `Success`', () {
      delegate.reset;
      exceptionHandler.reset;
      errorHandler.reset;

      delegate.result = () => data;
      exceptionHandler.result = () {};
      errorHandler.result = () {};

      final result = runner();

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
        delegate.callCount,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        exceptionHandler.callCount,
        0,
        reason: '`exceptionHandler` should NOT be called ',
      );
      expect(
        errorHandler.callCount,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });

    test('WHEN `ERROR` is thwon THEN runner fails', () {
      delegate.reset;
      exceptionHandler.reset;
      errorHandler.reset;

      delegate.result = () => throw Error();
      exceptionHandler.result = () {};
      errorHandler.result = () {};

      Error? err;

      try {
        runner();
      } on Error catch (e) {
        err = e;
      }

      expect(
        err != null,
        true,
        reason: '`Error` should NOT be handled',
      );
      expect(
        delegate.callCount,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        exceptionHandler.callCount,
        0,
        reason: '`exceptionHandler` should NOT be called ',
      );
      expect(
        errorHandler.callCount,
        0,
        reason: '`errorHandler` should NOT be called',
      );
      ;
    });
    // !! TEST FAILS

    test('WHEN `AssertionError` is thwon THEN gets handled', () {
      delegate.reset;
      exceptionHandler.reset;
      errorHandler.reset;

      delegate.result = () => throw AssertionError();
      exceptionHandler.result = () {};
      errorHandler.result = () {};

      expect(
        runner(),
        isA<Failure>(),
        reason: '`Error` should be handled',
      );
      expect(
        delegate.callCount,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        exceptionHandler.callCount,
        0,
        reason: '`exceptionHandler` should NOT be called ',
      );
      expect(
        errorHandler.callCount,
        1,
        reason: '`errorHandler` should be called once',
      );
    });
  });
}
