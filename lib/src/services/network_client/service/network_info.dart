part of 'network_client.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get connectionStatus;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<bool> get connectionStatus {
    return connectionChecker.onStatusChange.asyncMap((status) {
      return status == InternetConnectionStatus.connected;
    });
  }
}
