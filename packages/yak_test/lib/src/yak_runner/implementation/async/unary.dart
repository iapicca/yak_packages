import 'dart:async';

import 'package:test/test.dart';
import 'package:yak_error_handler/yak_error_handler.dart';
import 'package:yak_runner/yak_runner.dart';
import '../../../mocks/all.dart';
//  ignore_for_file: avoid_catching_errors

/// a test for `YakRunnerArgAsync`
class YakRunnerArgAsyncTest<T, S> implements YakRunnerArgTestDelegate<T, S> {
  /// takes the argument `description`
  YakRunnerArgAsyncTest({
    required this.description,
  });

  /// `description` is a `String`
  /// it will be passed to the `test` when runned
  final String description;

  /// `arg` and `result` are meant for `type` matching and *must not be null*
  /// `result` can be anything if `T` is void
  @override
  void call(FutureOr<T> respose, FutureOr<S> arg) {
    group(description, () {
      final exceptionStub = HandleExceptionDelegateStub();
      final errorStub = HandleErrorDelegateStub();
      final errorHandler = ErrorHandler<AssertionError>(errorStub);
      final delegate = MockUnaryDelegate<Future<T>, FutureOr<S>>();
      final runner = YakRunnerArgAsync<T, S>(
        delegate,
        exceptionHandler: exceptionStub,
        errorHandlers: {errorHandler},
      );

      test('WHEN `void Function(T)` throws THEN `Result` is `Failure`',
          () async {
        delegate.reset;
        exceptionStub.reset;
        errorStub.reset;

        delegate.stub = () => throw Exception();
        exceptionStub.stub = () {};
        errorStub.stub = () {};

        final result = await runner(arg);

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
          exceptionStub.callCount,
          1,
          reason: '`exceptionStub` should be called once',
        );
        expect(
          errorStub.callCount,
          0,
          reason: '`errorHandler` should NOT be called',
        );
      });

      test('WHEN `void Function()` does not fail `Result` is `Success`',
          () async {
        delegate.reset;
        exceptionStub.reset;
        errorStub.reset;
        final res = await respose;
        delegate.stub = () async => await res;
        exceptionStub.stub = () {};
        errorStub.stub = () {};

        final result = await runner(arg);

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
          exceptionStub.callCount,
          0,
          reason: '`exceptionStub` should NOT be called ',
        );
        expect(
          errorStub.callCount,
          0,
          reason: '`errorHandler` should NOT be called',
        );
      });
      test('WHEN `ERROR` is thwon THEN runner fails', () async {
        delegate.reset;
        exceptionStub.reset;
        errorStub.reset;

        delegate.stub = () => throw Error();
        exceptionStub.stub = () {};
        errorStub.stub = () {};

        Error? err;

        try {
          await runner(arg);
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
          exceptionStub.callCount,
          0,
          reason: '`exceptionStub` should NOT be called ',
        );
        expect(
          errorStub.callCount,
          0,
          reason: '`errorHandler` should NOT be called',
        );
      });

      test('WHEN `AssertionError` is thwon THEN gets handled', () async {
        delegate.reset;
        exceptionStub.reset;
        errorStub.reset;

        delegate.stub = () => throw AssertionError();
        exceptionStub.stub = () {};
        errorStub.stub = () {};

        expect(
          await runner(arg),
          isA<Failure>(),
          reason: '`Error` should be handled',
        );
        expect(
          delegate.callCount,
          1,
          reason: '`delegate` should be called once',
        );
        expect(
          exceptionStub.callCount,
          0,
          reason: '`exceptionStub` should NOT be called ',
        );
        expect(
          errorStub.callCount,
          1,
          reason: '`errorHandler` should be called once',
        );
      });
    });
  }
}
