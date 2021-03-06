import '../../all.dart';

/// an extension on type `<S extends T>` to safely cast as type `T`
/// or if `S` and <T extends S> and `S` is actually a `T`
///
/// for example Result.asType<Failure>()
///
extension RunnerTypeAsTypeExtension<S> on S {
  /// returns a `Result<T>`
  Result<T> asType<T>() {
    final runner = AsType<T, S>();
    return runner(this);
  }
}
