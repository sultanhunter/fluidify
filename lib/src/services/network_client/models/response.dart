part of 'network_client_entities.dart';

@immutable
class FluidifyApiResponse {
  const FluidifyApiResponse(
    this.body,
    this.statusCode,
    this.request, {
    this.headers = const <String, String>{},
  }) : assert(
          statusCode <= 561 && statusCode >= 100,
          'Status code must be between 100 and 561',
        );

  final String body;
  final int statusCode;
  final FluidifyApiRequest request;
  final Map<String, String> headers;
}
