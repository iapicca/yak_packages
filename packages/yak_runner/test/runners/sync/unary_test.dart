import 'package:stub/stub.dart';
import 'package:test/test.dart';
import 'package:yak_error_handler/yak_error_handler.dart';
import 'package:yak_runner/yak_runner.dart';
import '../../mocks/all.dart';
//  ignore_for_file: avoid_catching_errors

void main() {
  group('`UnaryRunner`', () {
    const data = 1;
    final mockExceptionHandler = MockHandleExceptionDelegate()
      ..stub.stub = (_) {};
    final errorStub = unaryStub<void, Error>()..stub = (_) {};
    final errorHandler = ErrorHandler<AvowError>(errorStub.wrap);
    final delegate = unaryStub<String, int>();

    final runner = UnaryRunner<String, int>(
      delegate.wrap,
      exceptionHandler: mockExceptionHandler,
      errorHandlers: {errorHandler},
    );

    test('WHEN `void Function(T)` throws THEN `Result` is `Failure`', () {
      delegate.reset;
      mockExceptionHandler.stub.reset;

      errorStub.reset;

      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (i) => throw Exception();

      final result = runner(data);

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
        reason: '`exceptionStub` should be called once',
      );
      expect(
        errorStub.count,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });

    test('WHEN `void Function()` does not fail `Result` is `Success`', () {
      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (i) => '$i';

      final result = runner(data);

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
        reason: '`exceptionStub` should NOT be called ',
      );
      expect(
        errorStub.count,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });
    test('WHEN `ERROR` is thwon THEN runner fails', () {
      delegate.reset;
      mockExceptionHandler.stub.reset;
      errorStub.reset;

      delegate.stub = (_) => throw Error();

      expect(
        () => runner(data),
        throwsA(isA<Error>()),
        reason: '`Error` should NOT be handled',
      );
      expect(
        delegate.count,
        1,
        reason: '`delegate` should be called once',
      );
      expect(
        mockExceptionHandler.stub.count,
        0,
        reason: '`exceptionStub` should NOT be called ',
      );
      expect(
        errorStub.count,
        0,
        reason: '`errorHandler` should NOT be called',
      );
    });
    test('WHEN `AvowError` is thwon THEN gets handled', () {
      delegate.reset;
      mockExceptionHandler.stub.reset;

      errorStub.reset;

      delegate.stub = (i) {
        avow(false);
        return '$i';
      };

      expect(
        runner(data),
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
        reason: '`exceptionStub` should NOT be called ',
      );
      expect(
        errorStub.count,
        1,
        reason: '`errorHandler` should be called once',
      );
    });
  });
}
