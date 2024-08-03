part of 'network_client.dart';

class HttpClientImpl implements NetworkClient {
  HttpClientImpl({
    required http.Client client,
    required String host,
    this.requestInterceptors = const [],
    this.responseInterceptors = const [],
    this.authorizationToken = '',
  })  : _client = client,
        _host = host;
  final http.Client _client;

  final String _host;
  final String authorizationToken;
  final List<RequestInterceptor> requestInterceptors;
  final List<ResponseInterceptor> responseInterceptors;

  bool get shouldAuthorise => authorizationToken.isNotEmpty;

  @override
  Future<ApiResponse> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  }) async {
    headers ??= <String, String>{}
      ..addAll({'Content-Type': 'application/json'});
    if (shouldAuthorise) {
      headers.addAll({'Authorization': authorizationToken});
    }
    final request = await _interceptedRequest(
      ApiRequest(
        Method.delete.value,
        _host,
        path,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ),
    );
    final networkResponse = await _client.delete(
      request.uri,
      headers: request.headers,
      body: request.body,
    );
    final response =
        await _interceptedResponse(_responseFrom(networkResponse, request));
    return _handleStatusCode(response);
  }

  @override
  Future<ApiResponse> download(
    Uri uri,
    File file, {
    Map<String, String>? headers,
  }) async {
    if (shouldAuthorise) {
      headers ??= <String, String>{}
        ..addAll({'Authorization': authorizationToken});
    }
    final request = await _interceptedRequest(
      ApiRequest(
        Method.get.value,
        uri.host,
        uri.path,
        headers: headers,
      ),
    );
    final url = Uri.https(request.host, request.path);
    final networkRequest = http.Request(Method.get.value, url);
    final networkResponse = await _client.send(networkRequest);
    final result = await http.Response.fromStream(networkResponse);
    final bytes = result.bodyBytes;
    await file.writeAsBytes(bytes);
    final response = await _interceptedResponse(_responseFrom(result, request));
    return _handleStatusCode(response);
  }

  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    if (shouldAuthorise) {
      headers ??= <String, String>{}
        ..addAll({'Authorization': authorizationToken});
    }

    final request = await _interceptedRequest(
      ApiRequest(
        Method.get.value,
        _host,
        path,
        headers: headers,
        queryParameters: queryParameters,
      ),
    );
    final url = Uri.https(request.host, request.path, request.queryParameters);
    final networkResponse = await _client.get(url, headers: request.headers);
    final response =
        await _interceptedResponse(_responseFrom(networkResponse, request));
    return _handleStatusCode(response);
  }

  @override
  Future<ApiResponse> multipart(
    String path,
    List<File> files, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  }) async {
    headers ??= <String, String>{}
      ..addAll({'Content-Type': 'multipart/form-data'});
    if (shouldAuthorise) {
      headers.addAll({'Authorization': authorizationToken});
    }
    final post = Method.post.value;
    final request = await _interceptedRequest(
      ApiRequest(
        post,
        _host,
        path,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ),
    );
    final url = Uri.https(request.host, request.path, request.queryParameters);
    final networkRequest = http.MultipartRequest(post, url);

    networkRequest.files.addAll(
      await Future.wait(
        files.map(
          (e) => http.MultipartFile.fromPath('upload', e.path),
        ),
      ),
    );
    networkRequest.fields.addAll(
      Map<String, String>.from(
        jsonDecode(body ?? '{}') as Map<String, dynamic>,
      ),
    );
    networkRequest.headers.addAll(request.headers ?? <String, String>{});

    final networkResponse = await _client.send(networkRequest);

    final result = await http.Response.fromStream(networkResponse);
    final response = await _interceptedResponse(_responseFrom(result, request));
    return _handleStatusCode(response);
  }

  @override
  Future<ApiResponse> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  }) async {
    headers ??= <String, String>{};
    headers.addAll({'Content-Type': 'application/json'});
    if (shouldAuthorise) {
      headers.addAll({'Authorization': authorizationToken});
    }
    final request = await _interceptedRequest(
      ApiRequest(
        Method.post.value,
        _host,
        path,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ),
    );
    final networkResponse = await _client.post(
      request.uri,
      headers: request.headers,
      body: request.body,
    );
    final response =
        await _interceptedResponse(_responseFrom(networkResponse, request));
    return _handleStatusCode(response);
  }

  @override
  Future<ApiResponse> put(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  }) async {
    headers ??= <String, String>{}
      ..addAll({'Content-Type': 'application/json'});
    if (shouldAuthorise) {
      headers.addAll({'Authorization': authorizationToken});
    }
    final request = await _interceptedRequest(
      ApiRequest(
        Method.put.value,
        _host,
        path,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ),
    );
    final url = Uri.https(request.host, request.path, request.queryParameters);
    final networkResponse = await _client.put(
      url,
      headers: request.headers,
      body: request.body,
    );
    final response =
        await _interceptedResponse(_responseFrom(networkResponse, request));
    return _handleStatusCode(response);
  }

  @override
  Future<ApiResponse> custom({
    required Method method,
    required String path,
    String? host,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  }) async {
    headers ??= <String, String>{}
      ..addAll({'Content-Type': 'application/json'});
    if (shouldAuthorise) {
      headers.addAll({'Authorization': authorizationToken});
    }
    final request = await _interceptedRequest(
      ApiRequest(
        method.value,
        host ?? _host,
        path,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ),
    );
    final url = Uri.https(request.host, request.path, request.queryParameters);
    late final http.Response networkResponse;
    if (method.value == 'POST') {
      networkResponse = await _client.post(
        url,
        headers: request.headers,
        body: request.body,
      );
    } else if (method.value == 'PATCH') {
      networkResponse = await _client.patch(
        url,
        headers: request.headers,
        body: request.body,
      );
    }
    final response =
        await _interceptedResponse(_responseFrom(networkResponse, request));
    return _handleStatusCode(response);
  }

  ApiResponse _handleStatusCode(ApiResponse response) {
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return response;
    } else if (response.statusCode == 500) {
      throw InternalServerError(response);
    } else if (response.statusCode == 403) {
      throw ServerAuthException(response);
    } else {
      throw ServerException(response);
    }
  }

  Future<ApiRequest> _interceptedRequest(ApiRequest request) async {
    var interceptedRequest = request;
    for (final interceptor in requestInterceptors) {
      interceptedRequest = await interceptor(request);
    }
    return interceptedRequest;
  }

  Future<ApiResponse> _interceptedResponse(ApiResponse response) async {
    var alteredResponse = response;
    for (final interceptor in responseInterceptors) {
      alteredResponse = await interceptor(response);
    }
    return alteredResponse;
  }

  ApiResponse _responseFrom(http.Response response, ApiRequest request) {
    return ApiResponse(
      response.body,
      response.statusCode,
      request,
      headers: response.headers,
    );
  }
}
