part of 'service/network_client.dart';

class InternalServerError implements Exception {
  const InternalServerError(this.message);

  final Object message;
}

class ServerAuthException extends ServerException {
  const ServerAuthException(super.message);
}

class ServerException implements Exception {
  const ServerException(this.message);
  final Object message;
}

class SpamResponseException implements Exception {
  const SpamResponseException(this.message);
  final String message;
}

class NoInternetConnection implements Exception {
  const NoInternetConnection();
}

class CommonException implements Exception {
  const CommonException(this.message);
  final String message;
}
