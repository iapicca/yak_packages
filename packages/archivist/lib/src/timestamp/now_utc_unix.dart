import '../../archivist.dart';

/// a `TimeStamp` for `utc unixtime`
TimeStamp get nowUtcUnix => () => DateTime.now().toUtc().millisecondsSinceEpoch;
