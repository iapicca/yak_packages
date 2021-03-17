import 'package:meta/meta.dart';

/// a mixin for `one-time` classes
/// that track the time of their active lifecycle
mixin TimeStampMixin {
  /// returns the `timestamp` of the current time
  int Function() get now;

  /// returns the `timestamp` of the initialization of the active lifecycle
  late final int started;

  /// returns the `timestamp` of the disposition of the active lifecycle
  int? get ended;
  @internal
  set ended(int? now);
}
