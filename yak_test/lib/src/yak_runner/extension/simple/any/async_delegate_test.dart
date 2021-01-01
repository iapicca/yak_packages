import 'package:yak_runner/yak_runner.dart';
import 'package:yak_test/src/yak_runner/factory/all.dart';

extension TryAnyRunAsyncTestFactoryExtension on TryAnyRunAsync {
  TryAnyRunAsyncTestFactory buildTestFactory(String description) =>
      TryAnyRunAsyncTestFactory(description);
}