import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../yak_runner.dart';

abstract class YakAsyncFunctionInterface<T,S> {
  FutureOr<T> call(FutureOr<S> argument);
}

class YakAsyncFunction<T,S> {
  const YakAsyncFunction({
    @required this.function,
    this.timeout,
  }) : assert(function != null);
  final FutureOr<T> Function(FutureOr<S> argument) function;
  final Duration timeout;

  FutureOr<Either<Failure,T>> call(FutureOr<S> argument) async {
    if(timeout != null) {
      Future.delayed(timeout, () {
        return Left( TimeOutFailure(), );
      });
    }
    T _result;
    try {
      _result = await function(await argument);
    } catch (_) {
      return Left( FunctionFailure(), );
    }
    if (_result == null) {
      return Left( NullFailure(), ); 
    } else {
      return Right(_result);
    }
  }
}
