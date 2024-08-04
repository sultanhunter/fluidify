part of 'network_client_entities.dart';

@immutable
class FluidifyApiRequest {
  const FluidifyApiRequest(
    this.method,
    this.host,
    this.path, {
    this.file,
    this.headers,
    this.queryParameters,
    this.body,
  });

  factory FluidifyApiRequest.fromJson(Json json) {
    return FluidifyApiRequest(
      json.asString('method'),
      json.asString('host'),
      json.asString('path'),
      file: json['file'] != null ? File(json.asString('file')) : null,
      headers: json.asMapN<String, String>('headers'),
      queryParameters: json.asMapN('queryParameters'),
      body: json.asStringN('body'),
    );
  }

  final String method;
  final String host;
  final String path;
  final File? file;
  final Map<String, String>? headers;
  final Map<String, String>? queryParameters;
  final String? body;

  Uri get uri => Uri.https(host, path, queryParameters);
}
