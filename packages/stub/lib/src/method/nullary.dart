import 'all.dart';

/// returns a NULLARY `stub`
///
/// to be replaced with `non-function type alias`
/// see [https://github.com/dart-lang/sdk/issues/44951]

StubMethod<T Function()> nullaryStub<T>() => NullaryStub<T, T Function()>();

/// a `NULLARY` implementation of `StubMethod`
/// it's recommended to use  `nullaryStub<T>()`
class NullaryStub<T, Z extends T Function()> extends StubMethod<Z>
    with Counter<Z> {
  Z? _stub;
  @override
  Z get stub {
    print(_stub == null);
    return _stub ?? _default;
  }

  @override
  set stub(Z fun) {
    print(fun);
    _stub = () {
      increase();
      return fun();
    } as Z;
  }

  Z get _default {
    return (() {
      increase();
      throw UnimplementedError();
    }) as Z;
  }
}
