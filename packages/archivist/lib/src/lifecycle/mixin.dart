import 'package:yak_runner/yak_runner.dart';

/// a mixin for a class with an `initialize` and `dispose` function
mixin LifeCycle {
  /// handle the `initialization` of the class
  /// recommended to use a `YakRunnerAsync` and `onFutureResult`
  Result<Future<void>> initialize();

  /// handles the `dispose` proccess of the class
  /// while the actual result is not meaningful
  /// the use of a `YakRunnerAsync` and `onFutureResult` is recommended
  /// for the `error handling` capabilities
  Result<Future<void>> dispose();
}
