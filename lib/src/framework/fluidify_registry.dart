import 'package:flutter/widgets.dart';

import '../action_parsers/fluidify_action_parser.dart';
import '../parsers/fluidify_parser.dart';
import '../utils/action_type.dart';
import '../utils/widget_type.dart';

class FluidifyRegistry {

  factory FluidifyRegistry() => _singleton;
  FluidifyRegistry._internal();

  static final FluidifyRegistry _singleton = FluidifyRegistry._internal();

  static FluidifyRegistry get instance => _singleton;

  static final _parsers = <WidgetType, FluidifyParser<dynamic>>{};

  static final _actionParsers = <ActionType, FluidifyActionParser<dynamic>>{};

  bool _registerParser(FluidifyParser<dynamic> parser) {
    final type = parser.type;
    if (_parsers.containsKey(type)) {
      debugPrint('Widget $type is already registered');
      return false;
    }
    _parsers[type] = parser;
    return true;
  }

  bool _registerAction(FluidifyActionParser<dynamic> parser) {
    final type = parser.actionType;
    if (_actionParsers.containsKey(type)) {
      debugPrint('Action $type is already registered');
      return false;
    }
    _actionParsers[type] = parser;
    return true;
  }

  void registerAllParsers(List<FluidifyParser<dynamic>> parsers) {
    for (final parser in parsers) {
      _registerParser(parser);
    }
  }

  void registerAllActions(List<FluidifyActionParser<dynamic>> parsers) {
    for (final parser in parsers) {
      _registerAction(parser);
    }
  }

  FluidifyParser<dynamic>? getParser(WidgetType type) {
    return _parsers[type];
  }

  FluidifyActionParser<dynamic>? getActionParser(ActionType type) {
    return _actionParsers[type];
  }
}
