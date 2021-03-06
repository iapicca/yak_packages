/// a delegate for a nullary function
/// a Delegate<T> can be assigned at a Nullary<T>
/// ```
/// class Foo implements Delegate<void> {
///   void call() {}
/// }
///  final Nullary delegate = Foo();
/// ```
mixin NullaryDelegate<T> {
  /// `call` represent `T Function()`
  T call();
}
