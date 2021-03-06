import 'package:test/test.dart';
import 'package:yak_error_handler/yak_error_handler.dart';
import 'package:yak_runner/yak_runner.dart';

void main() {
  final failure = Failure(ErrorReport());
  group('`TypeAsType`', () {
    test(
      'WHEN `<S extends T> as T` S.as<T>() THEN returns `Success<T>`',
      () => expect(
        failure.asType<Result>(),
        isA<Success<Result>>(),
        reason: '`<S extends T> as T `should be `Success<T>`',
      ),
    );

    test(
      'WHEN S.as<T>() THEN returns `Failure<T>`',
      () => expect(
        failure.asType<Success>(),
        isA<Failure<Success>>(),
        reason: '`S as T` should be `Failure<T>`',
      ),
    );
  });
}
