import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/network_client_entities.dart';

export '../models/network_client_entities.dart';

part '../exceptions.dart';

part 'http_client.dart';

part 'network_info.dart';

typedef RequestInterceptor = Future<FluidifyApiRequest> Function(
  FluidifyApiRequest apiRequest,
);

typedef ResponseInterceptor = Future<FluidifyApiResponse> Function(
  FluidifyApiResponse response,
);

abstract class NetworkClient {
  /// Sends a HTTP GET request with given [headers] to download the file from
  /// given [uri] and saves it on local disk.
  ///
  /// The downloaded file will be saved to the file referenced by [file] object.
  Future<FluidifyApiResponse> download(
    Uri uri,
    File file, {
    Map<String, String>? headers,
  });

  /// Sends a HTTP GET request with the given [headers] to the generated URL.
  ///
  /// [queryParameters] are parsed and added to the URL before request is sent.
  Future<FluidifyApiResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Sends a HTTP POST request with the given [headers] and [body] to the
  /// generated URL.
  ///
  /// [body] sets the body of the request. It should be JSON encoded String.
  ///
  /// The content-type is set to `"application/json"` by default in [headers].
  ///
  /// [queryParameters] are parsed and added to the URL before request is sent.
  Future<FluidifyApiResponse> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  });

  /// Sends a HTTP PUT request with the given [headers] and [body] to the
  /// generated URL.
  ///
  /// [body] sets the body of the request. It should be JSON encoded String.
  ///
  /// The content-type is set to `"application/json"` by default in [headers].
  ///
  /// [queryParameters] are parsed and added to the URL before request is sent.
  Future<FluidifyApiResponse> put(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  });

  /// Sends a HTTP DELETE request with the given [headers] and [body] to the
  /// generated URL.
  ///
  /// [body] sets the body of the request.
  ///
  /// The content-type is set to `"application/json"` by default in [headers].
  ///
  /// [queryParameters] are parsed and added to the URL before request is sent.
  Future<FluidifyApiResponse> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  });

  /// Sends a HTTP POST request to the generated URL, with given [headers],
  /// [body] and [files] to upload, referenced by given [files] object.
  ///
  /// [body] sets the body of the request. It should be JSON encoded String.
  ///
  /// The content-type is set to `"multipart/form-data"` by default in [headers].
  ///
  /// [queryParameters] are parsed and added to the URL before request is sent.
  Future<FluidifyApiResponse> multipart(
    String path,
    List<File> files, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  });

  /// Sends a CUSTOM HTTP request with the given [headers] and [body] to the
  /// generated URL.
  ///
  /// [body] sets the body of the request. It should be JSON encoded String.
  ///
  /// The content-type is set to `"application/json"` by default in [headers].
  ///
  /// [queryParameters] are parsed and added to the URL before request is sent.
  Future<FluidifyApiResponse> custom({
    required Method method,
    required String path,
    String? host,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
  });
}
