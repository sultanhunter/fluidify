import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import '../action_parsers/fluidify_action_parser.dart';
import '../parsers/fluidify_parser.dart';
import '../services/fluidify_network_service.dart';
import '../services/network_client/service/network_client.dart';
import '../utils/action_type.dart';
import '../utils/map_extension.dart';
import '../utils/widget_type.dart';
import 'fluidify_registry.dart';

typedef ErrorWidgetBuilder = Widget Function(
  BuildContext context,
  dynamic error,
);

typedef LoadingWidgetBuilder = Widget Function(BuildContext context);

class Fluidify {
  void initialize() {
    final parsers = <FluidifyParser<dynamic>>[];
    final actionParsers = <FluidifyActionParser<dynamic>>[];

    FluidifyRegistry.instance.registerAllParsers(parsers);
    FluidifyRegistry.instance.registerAllActions(actionParsers);
    FluidifyNetworkService.initialize(
      HttpClientImpl(
        client: Client(),
        host: 'https://github.com',
      ),
    );
  }

  static Widget? fromJson(Json json, BuildContext context) {
    try {
      final widgetType = WidgetType.fromString(json.asString('type'));
      final parser = FluidifyRegistry.instance.getParser(widgetType);
      if (parser != null) {
        final data = parser.getWidgetDataModel(json);
        return parser.parseWidget(context, data);
      } else {
        debugPrint('Widget type [$widgetType] not supported');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static FutureOr<dynamic> actionOnCallFromJson(
    Json json,
    BuildContext context,
  ) {
    try {
      final actionType = ActionType.fromString(json.asString('actionType'));
      final actionParser =
          FluidifyRegistry.instance.getActionParser(actionType);
      if (actionParser != null) {
        final actionData = actionParser.getActionDataModel(json);
        return actionParser.onActionCall(context, actionData);
      } else {
        debugPrint('Action type [$actionType] not supported');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Widget fromNetwork({
    required BuildContext context,
    required FluidifyApiRequest request,
    LoadingWidgetBuilder? loadingWidget,
    ErrorWidgetBuilder? errorWidget,
  }) {
    return FutureBuilder<FluidifyApiResponse?>(
      future: FluidifyNetworkService.request(request),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            if (loadingWidget != null) {
              return loadingWidget(context);
            }
          case ConnectionState.done:
            if (snapshot.hasData) {
              final json =
                  (jsonDecode(snapshot.data.toString()) as Json?) ?? {};
              return Fluidify.fromJson(json, context) ??
                  const SizedBox.shrink();
            } else if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              if (errorWidget != null) {
                final widget = errorWidget(context, snapshot.error);
                return widget;
              }
            }
          default:
            return SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
