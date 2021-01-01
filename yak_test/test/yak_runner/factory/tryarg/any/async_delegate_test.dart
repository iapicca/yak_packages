import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:yak_runner/yak_runner.dart';
import 'package:yak_test/src/yak_runner/factory/all.dart';

typedef void TestFunction(FutureOr<String> result, FutureOr<int> arg);

void main() {
  group('`TryAnyRunTryArgAsyncTestFactory` test', () {
    test(
        'WHEN `TryAnyRunArgAsync<String, int>` buildTest with `TryAnyRunArgAsyncTestFactory` THEN returns `ArgResultTestDelegate<String, int>`',
        () async {
      final runner = TryAnyRunTryArgAsync<String, int>((_) => throw '', null);
      final tester = runner.buildTest(TryAnyRunTryArgAsyncTestFactory(''));

      expect(
        tester is ArgResultTestDelegate<String, int>,
        true,
        reason: 'tester should be ArgResultTestDelegate<String, int>',
      );

      expect(
        tester.call is TestFunction,
        true,
        reason:
            "`ArgResultTestFactoryDelegate.call` parameters' types should match `ArgDelegate` types",
      );
    });
  });
}