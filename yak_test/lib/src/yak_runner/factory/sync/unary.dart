import 'package:yak_runner/yak_runner.dart';
import '../../test/all.dart';

// implementation of `YakRunnerTestFactoryDelegate` from `yak_runner`

class YakRunnerArgTestFactory implements YakRunnerArgTestFactoryDelegate {
  const YakRunnerArgTestFactory(this.description);
  final String description;
  @override
  YakRunnerArgTestDelegate<T, S> call<T, S>() =>
      YakRunnerArgTest<T, S>(description: description);
}
