import 'package:meta/meta.dart';
import 'package:yak_runner/yak_runner.dart';

import '../../archivist.dart';

/// an interface for `Archivist`
abstract class ArchivistBase with LifeCycle {
  /// returns a `LocalDatabaseDelegate`
  @internal
  LocalDatabaseDelegate get local;

  /// returns a `RemoteDatabaseDelegate`
  @internal
  RemoteDatabaseDelegate get remote;

  /// handles the migration between databases
  Result<Future<void>> migrate({
    required LocalDatabaseDelegate? local,
    required RemoteDatabaseDelegate? remote,
  });
}
