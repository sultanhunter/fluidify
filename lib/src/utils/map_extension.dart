extension CopyMap<K, V> on Map<K, V> {
  Map<K, V> copy() => Map.fromEntries(entries);
}

const emptyJson = <String, Object?>{};

typedef Json<T extends Object?> = Map<String, T>;

extension JsonParse on Json {
  int asInt(String key, {int fallback = -1}) =>
      int.tryParse(this[key].toString()) ?? fallback;

  int? asIntN(String key) => int.tryParse(this[key].toString());

  String asString(String key, {String fallback = ''}) =>
      this[key]?.toString() ?? fallback;

  String? asStringN(String key) => this[key]?.toString();

  bool asBool(String key, {bool fallback = false}) =>
      this[key] as bool? ?? fallback;

  bool? asBoolN(String key) => this[key] as bool?;

  double asDouble(String key, {double fallback = -1}) =>
      double.tryParse(this[key].toString()) ?? fallback;

  double? asDoubleN(String key) => double.tryParse(this[key].toString());

  Map<K, T> asMap<K, T>(String key, {Map<K, T>? fallback}) =>
      (this[key] as Map? ?? fallback ?? <K, T>{}).cast<K, T>();

  Map<K, T>? asMapN<K, T>(String key) => (this[key] as Map?)?.cast<K, T>();

  Json<T> asJson<T extends Object?>(String key, {Json<T>? fallback}) =>
      asMap<String, T>(key, fallback: fallback);

  Json<T>? asJsonN<T extends Object?>(String key) => asMapN<String, T>(key);

  List<T> asList<T>(String key, {List<T>? fallback}) =>
      (this[key] as List? ?? fallback ?? <T>[]).cast<T>();

  List<Json> asJsonList<T extends Object?>(String key,
          {List<Json<T>>? fallback}) =>
      asList<Json<T>>(key, fallback: fallback);

  List<T>? asListN<T>(String key) => (this[key] as List?)?.cast<T>();

  List<Json>? asJsonListN(String key) => asListN<Json>(key);

  bool has(String key) => this[key] != null;

  T? asCustom<T extends Object?>(String key, {T? fallback}) =>
      this[key] as T? ?? fallback;

  T parse<T>(String key, T Function(Json) parser) {
    try {
      return parser(asJson(key));
    } catch (e) {
      throw Exception('Unable to parse $key as $T');
    }
  }

  T? parseN<T>(String key, T Function(Json) parser, {T? fallback}) {
    try {
      return parser(asJson(key));
    } catch (e) {
      return fallback;
    }
  }

  T? makeN<T, P>(P? value, T Function(P) factory, [T? fallback]) {
    if (value == null) return fallback;
    return factory(value);
  }
}
