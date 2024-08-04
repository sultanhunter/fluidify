import 'package:flutter/widgets.dart';

import '../utils/map_extension.dart';
import '../utils/widget_type.dart';

abstract class FluidifyParser<T> {
  WidgetType get type;

  T getWidgetDataModel(Json json);

  Widget parseWidget(BuildContext context, T data);

}