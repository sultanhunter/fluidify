import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../services/fluidify_network_service.dart';
import '../../services/network_client/models/network_client_entities.dart';
import '../../utils/action_type.dart';
import '../../utils/map_extension.dart';
import '../fluidify_action_parser.dart';

class FluidifyNetworkRequestParser
    implements FluidifyActionParser<FluidifyApiRequest> {
  @override
  ActionType get actionType => ActionType.networkRequest;

  @override
  FluidifyApiRequest getActionDataModel(Json<Object?> json) {
    return FluidifyApiRequest.fromJson(json);
  }

  @override
  FutureOr<FluidifyApiResponse?> onActionCall(
    BuildContext context,
    FluidifyApiRequest data,
  ) async {
    try {
      final response = await FluidifyNetworkService.request(data);
      return response;
    } catch (e) {
      return null;
    }
  }
}
