import 'dart:async';

import '../../../freezed/void/sync.dart';
import '../../../freezed/any/sync.dart';
import '../../base/delegate.dart';

/// `TryRunAsyncArg` takes a `void Function(T) || Future<void> Function(T)`
/// and a `TryAnyRunAsync` (or equivalent)
/// as a parameter and effectively turns it into a `TryRunAsync`

///  it is not meant to be used directly in frontend
/// prefer using a `state_notifier` and `TryAsync` for that

class TryRunAsyncArg<T> implements Delegate<Future<Try>> {
  const TryRunAsyncArg(this.fun, this.arg);
  final FutureOr<void> Function(T) fun;

  /// you can pass a `TryAnyRunAsync` ot `TryAnyRun` as `arg`
  final Future<TryAny<T>> Function() arg;
  @override
  Future<Try> call() async {
    Try res;
    final _arg = await arg();
    _arg.when(success: (T t) async {
      try {
        await fun(t);
        res = Try.success();
      } catch (e, s) {
        res = Try.failure(e, s);
      }
    }, failure: (e, s) {
      res = Try.failure(e, s);
    });
    return res;
  }
}