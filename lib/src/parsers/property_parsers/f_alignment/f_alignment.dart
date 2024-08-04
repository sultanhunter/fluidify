import 'package:flutter/widgets.dart';
import '../../../utils/map_extension.dart';

abstract class FAlignmentGeometry {
  const FAlignmentGeometry();

  ///{
  /// 'type':'alignment' OR 'directional'
  /// 'value':'topLeft' OR {'x':1,'y':1}
  /// }
  static FAlignmentGeometry? fromJson(Json json) {
    final type = json.asString('type');
    switch (type) {
      case 'alignment':
        final isString = json.isString('value');
        final isJson = json.isJson('value');
        if (isString) {
          return FAlignment.fromString(json.asString('value'));
        } else if (isJson) {
          return FAlignment.fromJson(json.asJson('value'));
        }
      case 'directional':
        final isString = json.isString('value');
        final isJson = json.isJson('value');
        if (isString) {
          return FAlignmentDirectional.fromString(json.asString('value'));
        } else if (isJson) {
          return FAlignmentDirectional.fromJson(json.asJson('value'));
        }
    }
    return null;
  }
}

class FAlignment extends FAlignmentGeometry {
  const FAlignment(this.x, this.y);

  factory FAlignment.fromJson(Json json) {
    final x = json.asDouble('x', fallback: 0);
    final y = json.asDouble('y', fallback: 0);
    return FAlignment(x, y);
  }

  factory FAlignment.fromString(String string) {
    switch (string) {
      case 'topLeft':
        return FAlignment.topLeft;
      case 'topCenter':
        return FAlignment.topCenter;
      case 'topRight':
        return FAlignment.topRight;
      case 'centerLeft':
        return FAlignment.centerLeft;
      case 'center':
        return FAlignment.center;
      case 'centerRight':
        return FAlignment.centerRight;
      case 'bottomLeft':
        return FAlignment.bottomLeft;
      case 'bottomCenter':
        return FAlignment.bottomCenter;
      case 'bottomRight':
        return FAlignment.bottomRight;
      default:
        return FAlignment.topLeft;
    }
  }

  final double x;
  final double y;

  /// The top left corner.
  static const FAlignment topLeft = FAlignment(-1, -1);

  /// The center point along the top edge.
  static const FAlignment topCenter = FAlignment(0, -1);

  /// The top right corner.
  static const FAlignment topRight = FAlignment(1, -1);

  /// The center point along the left edge.
  static const FAlignment centerLeft = FAlignment(-1, 0);

  /// The center point, both horizontally and vertically.
  static const FAlignment center = FAlignment(0, 0);

  /// The center point along the right edge.
  static const FAlignment centerRight = FAlignment(1, 0);

  /// The bottom left corner.
  static const FAlignment bottomLeft = FAlignment(-1, 1);

  /// The center point along the bottom edge.
  static const FAlignment bottomCenter = FAlignment(0, 1);

  /// The bottom right corner.
  static const FAlignment bottomRight = FAlignment(1, 1);

  Alignment get parse {
    switch (this) {
      case FAlignment.topLeft:
        return Alignment.topLeft;
      case FAlignment.topCenter:
        return Alignment.topCenter;
      case FAlignment.topRight:
        return Alignment.topRight;
      case FAlignment.centerLeft:
        return Alignment.centerLeft;
      case FAlignment.center:
        return Alignment.center;
      case FAlignment.centerRight:
        return Alignment.centerRight;
      case FAlignment.bottomLeft:
        return Alignment.bottomLeft;
      case FAlignment.bottomCenter:
        return Alignment.bottomCenter;
      case FAlignment.bottomRight:
        return Alignment.bottomRight;
      default:
        return Alignment(x, y);
    }
  }
}

class FAlignmentDirectional extends FAlignmentGeometry {
  const FAlignmentDirectional(this.start, this.y);

  factory FAlignmentDirectional.fromJson(Json json) {
    final start = json.asDouble('start', fallback: 0);
    final y = json.asDouble('y', fallback: 0);
    return FAlignmentDirectional(start, y);
  }

  factory FAlignmentDirectional.fromString(String string) {
    switch (string) {
      case 'topStart':
        return FAlignmentDirectional.topStart;
      case 'topCenter':
        return FAlignmentDirectional.topCenter;
      case 'topEnd':
        return FAlignmentDirectional.topEnd;
      case 'centerStart':
        return FAlignmentDirectional.centerStart;
      case 'center':
        return FAlignmentDirectional.center;
      case 'centerEnd':
        return FAlignmentDirectional.centerEnd;
      case 'bottomStart':
        return FAlignmentDirectional.bottomStart;
      case 'bottomCenter':
        return FAlignmentDirectional.bottomCenter;
      case 'bottomEnd':
        return FAlignmentDirectional.bottomEnd;
      default:
        return FAlignmentDirectional.topStart;
    }
  }

  final double start;
  final double y;

  /// The top corner on the "start" side.
  static const FAlignmentDirectional topStart = FAlignmentDirectional(-1, -1);

  /// The center point along the top edge.
  ///
  /// Consider using [Alignment.topCenter] instead, as it does not need
  /// to be [resolve]d to be used.
  static const FAlignmentDirectional topCenter = FAlignmentDirectional(0, -1);

  /// The top corner on the "end" side.
  static const FAlignmentDirectional topEnd = FAlignmentDirectional(1, -1);

  /// The center point along the "start" edge.
  static const FAlignmentDirectional centerStart = FAlignmentDirectional(-1, 0);

  /// The center point, both horizontally and vertically.
  ///
  /// Consider using [Alignment.center] instead, as it does not need to
  /// be [resolve]d to be used.
  static const FAlignmentDirectional center = FAlignmentDirectional(0, 0);

  /// The center point along the "end" edge.
  static const FAlignmentDirectional centerEnd = FAlignmentDirectional(1, 0);

  /// The bottom corner on the "start" side.
  static const FAlignmentDirectional bottomStart = FAlignmentDirectional(-1, 1);

  /// The center point along the bottom edge.
  ///
  /// Consider using [Alignment.bottomCenter] instead, as it does not
  /// need to be [resolve]d to be used.
  static const FAlignmentDirectional bottomCenter = FAlignmentDirectional(0, 1);

  /// The bottom corner on the "end" side.
  static const FAlignmentDirectional bottomEnd = FAlignmentDirectional(1, 1);

  AlignmentDirectional get parse {
    switch (this) {
      case FAlignmentDirectional.topStart:
        return AlignmentDirectional.topStart;
      case FAlignmentDirectional.topCenter:
        return AlignmentDirectional.topCenter;
      case FAlignmentDirectional.topEnd:
        return AlignmentDirectional.topEnd;
      case FAlignmentDirectional.centerStart:
        return AlignmentDirectional.centerStart;
      case FAlignmentDirectional.center:
        return AlignmentDirectional.center;
      case FAlignmentDirectional.centerEnd:
        return AlignmentDirectional.centerEnd;
      case FAlignmentDirectional.bottomStart:
        return AlignmentDirectional.bottomStart;
      case FAlignmentDirectional.bottomCenter:
        return AlignmentDirectional.bottomCenter;
      case FAlignmentDirectional.bottomEnd:
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional(start, y);
    }
  }
}
