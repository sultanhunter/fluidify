part of 'network_client_entities.dart';

@immutable
class ApiRequest {
  const ApiRequest(
    this.method,
    this.host,
    this.path, {
    this.file,
    this.headers,
    this.queryParameters,
    this.body,
  });

  final String host;
  final String path;
  final File? file;
  final Map<String, String>? headers;
  final Map<String, String>? queryParameters;
  final String? body;
  final String method;

  Uri get uri => Uri.https(host, path, queryParameters);
}
