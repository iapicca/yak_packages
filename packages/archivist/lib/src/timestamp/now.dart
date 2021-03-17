class _ConstantDateTimeNowUtcUnix {
  /// returns a timestamp `utc unixtime`
  int call() => DateTime.now().toUtc().millisecondsSinceEpoch;
  const _ConstantDateTimeNowUtcUnix();
}

/// a const `TimeStamp` for `utc unixtime`
const nowUtcUnix = _ConstantDateTimeNowUtcUnix();
