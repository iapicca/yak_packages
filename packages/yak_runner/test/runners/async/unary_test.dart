import 'dart:async';

import 'package:stub/stub.dart';
import 'package:test/test.dart';
import 'package:yak_error_handler/yak_error_handler.dart';
import 'package:yak_runner/yak_runner.dart';
import '../../mocks/all.dart';

void main() {
  const data = 1;
  group('`UnaryRunnerAsync`', () {
    final mockExceptionHandler = MockHandleExceptionDelegate()
      ..stub.stub = (_) {};
    final errorStub = unaryStub<void, Error>()..stub = (_) {};
    final errorHandler = ErrorHandler<AvowError>(errorStub.wrap);
    final delegate = unaryStub<Future<String>, FutureOr<int>>();
    final runner = UnaryRunnerAsync<String, int>(
      delegate.wrap,
      exceptionHandler: mockExceptionHandler,
      errorHandlers: {errorHandler},
    );

    test('WHEN `void Function(T)` throws THEN `Result` is `Failure`', () async {
      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (i) async => throw Exception();

      final result = await runner(data);

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
        delegate.count,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        mockExceptionHandler.stub.count,
        1,
        reason: '`mockExceptionHandler` should be called once',
      );
      expect(
        errorStub.count,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });

    test('WHEN `void Function()` does not fail `Result` is `Success`',
        () async {
      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (i) async => '';

      final result = await runner(data);

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
        delegate.count,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        mockExceptionHandler.stub.count,
        0,
        reason: '`mockExceptionHandler` should NOT be called ',
      );
      expect(
        errorStub.count,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });
    test('WHEN `ERROR` is thwon THEN runner fails', () async {
      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (_) => throw Error();

      late final err;

      try {
        await runner(data);
        // ignore: avoid_catching_errors
      } on Error catch (e) {
        err = e;
      }

      expect(
        err,
        isA<Error>(),
        reason: '`Error` should NOT be handled',
      );
      // expect(
      //   () => runner(data),
      //   throwsA(isA<Error>()),
      //   reason: '`Error` should NOT be handled',
      // );
      expect(
        delegate.count,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        mockExceptionHandler.stub.count,
        0,
        reason: '`mockExceptionHandler` should NOT be called ',
      );
      expect(
        errorStub.count,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });

    test('WHEN `AvowError` is thwon THEN gets handled', () async {
      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (i) async {
        avow(false);
        return '$i';
      };

      expect(
        await runner(data),
        isA<Failure>(),
        reason: '`Error` should be handled',
      );
      expect(
        delegate.count,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        mockExceptionHandler.stub.count,
        0,
        reason: '`mockExceptionHandler` should NOT be called ',
      );
      expect(
        errorStub.count,
        1,
        reason: '`errorHandler` should be called once',
      );
    });
  });
}
