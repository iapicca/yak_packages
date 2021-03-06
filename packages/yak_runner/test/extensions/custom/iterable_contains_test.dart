import 'package:test/test.dart';
import 'package:yak_runner/yak_runner.dart';

void main() {
  group('`YakRunnerIterableContainsExtension`', () {
    test('WHEN `Iterable<T>` containsResult THEN returns `Result<T>`', () {
      () => expect(
            [1, 2, 3, 4].containsResult(5),
            isA<Result<int>>(),
            reason: '`<T>[].containsResult()` should be `Result<T>`',
          );
    });
  });
}
