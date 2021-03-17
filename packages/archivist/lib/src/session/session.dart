import '../../archivist.dart';

/// an interface for a class that represent the time span of the app state
/// with reference for the app being
/// - opened / closed
/// - online / offline
abstract class Session with TimeStampMixin {
  Session._();

  /// provides the status of the connectivity for a given session
  ConnectivityResult get connectivity;

  /// provide the app version used in the seesion
  String? get appVersion;

  /// provides interaction for ***local*** database
  Interaction get local;

  /// provides interaction for ***remote*** database
  Interaction get remote;

  /// ends a sesssion assigning a timestamp to ended only if null
  void end();

  ///
  factory Session(
    ConnectivityResult connectivity, [
    TimeStamp now = nowUtcUnix,
    String? appVersion,
  ]) =>
      _Session._(
        connectivity,
        now,
        appVersion,
      );
}

class _Session extends Session {
  @override
  int? ended;

  @override
  final int started;

  @override
  final String? appVersion;

  @override
  final ConnectivityResult connectivity;

  @override
  TimeStamp now;

  @override
  final Interaction local;

  @override
  final Interaction remote;

  @override
  void end() => ended ??= now();

  _Session._(
    this.connectivity,
    this.now, [
    this.appVersion,
  ])  : local = Interaction(now),
        remote = Interaction(now),
        started = now(),
        super._();
}
