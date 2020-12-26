import 'package:flutter_test/flutter_test.dart';
import 'package:yak_runner/yak_runner.dart';
import 'package:mockito/mockito.dart';
import '../../base/mock_arg_delegate.dart';
import '../../base/mock_delegate.dart';
import '../../base/mock_error_handler.dart';

void main() {
  group('`TryAnyRunTryArg`', () {
    final _data = 'hello';
    final _errorHandler = MockErrorHandler();

    final _argDelegate = MockDelegate<TryAny<String>>();
    final _funDelegate = MockArgDelegate<int, String>();
    final _tryRun =
        TryAnyRunTryArg<int, String>(_funDelegate, _argDelegate, _errorHandler);
    when(_errorHandler.call(any, any)).thenAnswer((_) {});

    test('WHEN `arg`is `Failure` THEN `Try` is `Failure`', () {
      clearInteractions(_errorHandler);
      clearInteractions(_argDelegate);
      clearInteractions(_funDelegate);

      when(_funDelegate.call(_data)).thenAnswer((s) => _data.length);
      when(_argDelegate.call())
          .thenAnswer((_) => TryAny.failure('', StackTrace.fromString('')));

      final _result = _tryRun();

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

    test('WHEN `arg`is `Result` && fun() does not fail THEN `Try` is `Success`',
        () {
      clearInteractions(_errorHandler);
      clearInteractions(_argDelegate);
      clearInteractions(_funDelegate);

      when(_funDelegate.call(_data)).thenAnswer((s) => _data.length);
      when(_argDelegate.call()).thenAnswer((_) => TryAny.result(_data));

      final _result = _tryRun();

      expect(_result != null, true, reason: '`_result` must not be null');
      expect(_result is Success, true);
      expect(_result is Failure, false);

      var _resultData;
      var _resultFail;
      _result.when(
          result: (r) => _resultData = r, failure: (_, s) => _resultFail = s);

      expect(_resultData != null, true);
      expect(_resultData, _data.length);
      expect(_resultFail != null, false);

      verify(_argDelegate.call()).called(1);
      verifyNoMoreInteractions(_argDelegate);
      verify(_funDelegate.call(any)).called(1);
      verifyNoMoreInteractions(_funDelegate);
      verifyZeroInteractions(_errorHandler);
    });

    test('WHEN `arg`is `Result` but `fun()` throw THEN `Try` is `Failure`', () {
      clearInteractions(_errorHandler);
      clearInteractions(_argDelegate);
      clearInteractions(_funDelegate);

      when(_argDelegate.call()).thenAnswer((_) => TryAny.result(_data));
      when(_funDelegate.call(_data)).thenThrow('ops');

      final _result = _tryRun();

      expect(_result != null, true, reason: '`_result` must not be null');
      expect(_result is Success, false);
      expect(_result is Failure, true);

      var _resultData;
      var _resultFail;
      _result.when(
          result: (r) => _resultData = r, failure: (_, s) => _resultFail = s);

      expect(_resultData != null, false);
      expect(_resultFail != null, true);

      verify(_argDelegate.call()).called(1);
      verifyNoMoreInteractions(_argDelegate);
      verify(_funDelegate.call(any)).called(1);
      verifyNoMoreInteractions(_funDelegate);
      verify(_errorHandler.call(any, any)).called(1);
      verifyNoMoreInteractions(_errorHandler);
    });
  });
}