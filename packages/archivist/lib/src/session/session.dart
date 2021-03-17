import '../../archivist.dart';

/// an interface for a class that represent the time span of the app state
/// with reference for the app being
/// - opened / closed
/// - online / offline
abstract class Session with TimeStampMixin {
  Session._();

  /// provides the status of the connectivity for a given session
  ConnectivityStatus get connectivity;

  /// provide the app version used in the seesion
  String get appVersion;

  /// provide the uid
  String? get uid;

  /// provides interaction for ***local*** database
  Archive get local;

  /// provides interaction for ***remote*** database
  Archive get remote;

  ///
  factory Session({
    required String appVersion,
    required ConnectivityStatus connectivity,
    required TimeStamp now,
    String? uid,
  }) = _Session._;
}

///
class _Session extends Session {
  final TimeStamp now;

  @override
  int get latest => maybeMax(local.last, remote.last) ?? started;

  @override
  final int started;

  @override
  final String? uid;

  @override
  final String appVersion;

  @override
  final ConnectivityStatus connectivity;

  @override
  final Interaction local;

  @override
  final Interaction remote;

  _Session._({
    required this.appVersion,
    required this.connectivity,
    required this.now,
    this.uid,
  })  : local = Interaction(timeStamp: now),
        remote = Interaction(timeStamp: now),
        started = now(),
        super._();
}
