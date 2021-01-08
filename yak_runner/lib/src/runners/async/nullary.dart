import '../../classes/all.dart';
import '../../mixin/all.dart';
import '../../delegates/all.dart';

class YakRunnerAsync<T>
    with YakRunnerTestMixin
    implements Delegate<Future<Result<T>>> {
  const YakRunnerAsync(this.fun, [this.errorHandler]);
  final Future<T> Function() fun;
  final ErrorHandler errorHandler;

  Future<Result<T>> call() async {
    try {
      return Result.success(await fun());
    } catch (e, s) {
      errorHandler?.call(e, s);
      return Result.failure(e, s);
    }
  }
}