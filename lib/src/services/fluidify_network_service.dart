import 'network_client/service/network_client.dart';

class FluidifyNetworkService {
  const FluidifyNetworkService._();

  static late NetworkClient _client;

  static void initialize(NetworkClient client) => _client = client;

  static NetworkClient get client => _client;

  static Future<FluidifyApiResponse?> request(
      FluidifyApiRequest request) async {
    final method = request.method;
    if (method == Method.get.value) {
      return _client.get(
        request.path,
        headers: request.headers,
        queryParameters: request.queryParameters,
      );
    } else if (method == Method.post.value) {
      return _client.post(
        request.path,
        headers: request.headers,
        queryParameters: request.queryParameters,
      );
    } else if (method == Method.put.value) {
      return _client.put(
        request.path,
        headers: request.headers,
        queryParameters: request.queryParameters,
      );
    } else if (method == Method.put.value) {
      return _client.delete(
        request.path,
        headers: request.headers,
        queryParameters: request.queryParameters,
      );
    }
    return null;
  }
}
