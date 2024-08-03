part of 'network_client_entities.dart';

enum Method {
  delete,
  get,
  head,
  patch,
  post,
  put,
  read;

  String get value => name.toUpperCase();
}
