/// an interface that represent the conncctivity status
abstract class ConnectivityStatus {
  /// refers to a conncection through mobile network
  const factory ConnectivityStatus.mobile() = MobileConnection;

  /// refers to a conncection through mobile network
  const factory ConnectivityStatus.wifi() = WifiConnection;

  /// refers to a no conncection available
  const factory ConnectivityStatus.disconnected() = NoConnection;
}

/// refers to a conncection through mobile network
class MobileConnection implements ConnectivityStatus {
  /// has a const constructor
  const MobileConnection();
}

/// refers to a conncection through wifi network

class WifiConnection implements ConnectivityStatus {
  /// has a const constructor
  const WifiConnection();
}

/// refers to a no conncection available

class NoConnection implements ConnectivityStatus {
  /// has a const constructor
  const NoConnection();
}
