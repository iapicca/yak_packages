import 'package:yak_runner/yak_runner.dart';
import 'package:yak_test/src/yak_runner/factory/all.dart';

// an extension on `YakRunnerArg` that returns `YakRunnerTestFactory`

extension YakRunnerArgFactoryExtension on YakRunnerArg {
  YakRunnerArgTestFactory buildTestFactory(String description) =>
      YakRunnerArgTestFactory(description);
}
