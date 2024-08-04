import 'dart:async';

import 'package:flutter/widgets.dart';

import '../utils/action_type.dart';
import '../utils/map_extension.dart';

abstract class FluidifyActionParser<T> {
  ActionType get actionType;

  T getActionDataModel(Json json);

  FutureOr<dynamic> onActionCall(BuildContext context, T data);
}
