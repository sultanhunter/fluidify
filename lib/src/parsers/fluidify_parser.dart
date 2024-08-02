import 'package:flutter/widgets.dart';

import '../utils/map_extension.dart';

abstract class  FluidifyParser<T>{

  String get type;

  T getData(Json json);

  Widget parse(BuildContext context,T data);

}