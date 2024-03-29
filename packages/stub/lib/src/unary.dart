import 'package:yak_utils/yak_utils.dart' show Unary, UnaryDelegate;

import 'stub.dart';

class UnaryStub<T, S, Z extends Unary<T, S>> extends Stub<Z>
    implements UnaryDelegate<T, S> {
  Z? _stub;
  Z get _call => _stub ?? _default;
  @override
  set stub(Z fun) {
    _stub = (s) {
      increase();
      return fun(s);
    } as Z;
  }

  Z get _default {
    return ((_) {
      increase();
      throw UnimplementedError();
    }) as Z;
  }

  @override
  T call(S p0) => _call(p0);
}
