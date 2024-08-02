import 'dart:async';

import 'package:flutter/widgets.dart';

import '../utils/map_extension.dart';

abstract class FluidifyActionParser<T>{
  String get actionType;

  T getData(Json json);

  FutureOr<dynamic> onCall(BuildContext context,T data);
}