import 'package:flutter_test/flutter_test.dart';
import 'package:yak_runner/yak_runner.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import '../../base/mock_error_handler.dart';
import '../../base/mock_future_arg_delegate.dart';
import '../../base/mock_future_delegate.dart';

class TryAnyRunTryArgAsyncTester<T, S> {
  const TryAnyRunTryArgAsyncTester({
    @required this.description,
    @required this.arg,
    @required this.result,
  });
  final String description;
  final S arg;
  final T result;

  void call() {
    group('`TryAnyRunTryArgAsync`', () {
      final _errorHandler = MockErrorHandler();
      final _argDelegate = MockFutureDelegate<TryAny<S>>();
      final _funDelegate = MockFutureArgDelegate<T, S>();
      final _tryRun =
          TryAnyRunTryArgAsync<T, S>(_funDelegate, _argDelegate, _errorHandler);

      test('WHEN `arg`is `Failure` THEN `Try` is `Failure`', () async {
        clearInteractions(_errorHandler);
        clearInteractions(_argDelegate);
        clearInteractions(_funDelegate);

        when(_funDelegate.call(arg)).thenAnswer((_) async => result);
        when(_argDelegate.call())
            .thenAnswer((_) => TryAny.failure('', StackTrace.fromString('')));

        final _result = await _tryRun();

        expect(_result != null, true, reason: '`_result` must not be null');
        expect(_result is Success, false);
        expect(_result is Failure, true);

        var _resultData;
        var _resultFail;
        _result.when(
          result: (r) => _resultData = r,
          failure: (_, s) => _resultFail = s,
        );

        expect(_resultData != null, false);
        expect(_resultFail != null, true);

        verify(_argDelegate.call()).called(1);
        verifyNoMoreInteractions(_argDelegate);
        verifyZeroInteractions(_funDelegate);
        verifyZeroInteractions(_errorHandler);
      });

      test(
          'WHEN `arg`is `Result` && fun() does not fail THEN `Try` is `Success`',
          () async {
        clearInteractions(_errorHandler);
        clearInteractions(_argDelegate);
        clearInteractions(_funDelegate);

        when(_funDelegate.call(arg)).thenAnswer((_) async => result);
        when(_argDelegate.call()).thenAnswer((_) => TryAny.result(arg));
        final _result = await _tryRun();

        expect(_result != null, true, reason: '`_result` must not be null');
        expect(_result is Success, true);
        expect(_result is Failure, false);

        var _resultData;
        var _resultFail;
        _result.when(
          result: (r) => _resultData = r,
          failure: (_, s) => _resultFail = s,
        );

        expect(_resultData != null, true);
        expect(_resultFail != null, false);

        verify(_argDelegate.call()).called(1);
        verifyNoMoreInteractions(_argDelegate);
        verify(_funDelegate.call(any)).called(1);
        verifyNoMoreInteractions(_funDelegate);
        verifyZeroInteractions(_errorHandler);
      });

      test('WHEN `arg`is `Result` but `fun()` throw THEN `Try` is `Failure`',
          () async {
        clearInteractions(_errorHandler);
        clearInteractions(_argDelegate);
        clearInteractions(_funDelegate);

        when(_argDelegate.call()).thenAnswer((_) async => TryAny.result(arg));
        when(_funDelegate.call(arg)).thenThrow('ops');

        final _result = await _tryRun();

        expect(_result != null, true, reason: '`_result` must not be null');
        expect(_result is Success, false);
        expect(_result is Failure, true);

        var _resultData;
        var _resultFail;

        _result.when(
          result: (r) => _resultData = r,
          failure: (_, s) => _resultFail = s,
        );

        expect(_resultData != null, false);
        expect(_resultFail != null, true);

        verify(_argDelegate.call()).called(1);
        verifyNoMoreInteractions(_argDelegate);
        verify(_funDelegate.call(arg)).called(1);
        verifyNoMoreInteractions(_funDelegate);
        verify(_errorHandler.call(any, any)).called(1);
        verifyNoMoreInteractions(_errorHandler);
      });
    });
  }
}