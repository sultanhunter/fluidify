enum NetworkLogLevel {
  info,
  debug,
  verbose;

  static const NetworkLogLevel _debugLevel = debug;
  static bool get isDebug => _debugLevel == debug;
  static bool get isVerbose => _debugLevel == verbose;
  static bool get isInfo => _debugLevel == info;
}
