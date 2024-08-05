import 'package:flutter/widgets.dart';
import '../../../utils/map_extension.dart';

abstract class FEdgeInsetsGeometry {
  const FEdgeInsetsGeometry();

  static FEdgeInsetsGeometry? fromJson(Json json) {
    final type = json.asString('type');
    final value = json.asJson('value');
    switch (type) {
      case 'edgeInsets':
        return FEdgeInsets.fromJson(value);
      case 'edgeInsetsDirectional':
        return FEdgeInsetsDirectional.fromJson(value);
    }
    return null;
  }

  EdgeInsetsGeometry get parse;
}

class FEdgeInsets extends FEdgeInsetsGeometry {
  ///{
  ///'type':'all' OR 'symmetric' OR 'only' OR 'fromLTRB'
  ///'value':{
  ///'all':1,
  ///'horizontal':1,
  ///'vertical':1,
  ///'top':1,
  ///'bottom':1,
  ///'right':1,
  ///'left':1
  ///}
  /// }
  factory FEdgeInsets.fromJson(Json json) {
    final type = json.asString('type');
    final value = json.asJson('value');
    switch (type) {
      case 'all':
        final allValue = value.asDouble('all');
        return FEdgeInsets.all(allValue);
      case 'symmetric':
        final horizontalValue = value.asDouble('horizontal');
        final verticalValue = value.asDouble('vertical');
        return FEdgeInsets.symmetric(
          horizontal: horizontalValue,
          vertical: verticalValue,
        );
      case 'only':
        final topValue = value.asDouble('top');
        final bottomValue = value.asDouble('bottom');
        final rightValue = value.asDouble('right');
        final leftValue = value.asDouble('left');
        return FEdgeInsets.only(
          left: leftValue,
          top: topValue,
          right: rightValue,
          bottom: bottomValue,
        );
      default:
        return const FEdgeInsets.all(0);
    }
  }

  const FEdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom);

  const FEdgeInsets.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const FEdgeInsets.symmetric({double vertical = 0, double horizontal = 0})
      : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  const FEdgeInsets.only({
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
  });

  final double left;
  final double top;
  final double right;
  final double bottom;

  @override
  EdgeInsets get parse {
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }
}

class FEdgeInsetsDirectional extends FEdgeInsetsGeometry {
  factory FEdgeInsetsDirectional.fromJson(Json json) {
    final type = json.asString('type');
    final value = json.asJson('value');
    switch (type) {
      case 'all':
        final allValue = value.asDouble('all');
        return FEdgeInsetsDirectional.all(allValue);
      case 'symmetric':
        final horizontalValue = value.asDouble('horizontal');
        final verticalValue = value.asDouble('vertical');
        return FEdgeInsetsDirectional.symmetric(
          horizontal: horizontalValue,
          vertical: verticalValue,
        );
      case 'only':
        final topValue = value.asDouble('top');
        final bottomValue = value.asDouble('bottom');
        final endValue = value.asDouble('end');
        final startValue = value.asDouble('start');
        return FEdgeInsetsDirectional.only(
          start: startValue,
          top: topValue,
          end: endValue,
          bottom: bottomValue,
        );
      default:
        return const FEdgeInsetsDirectional.all(0);
    }
  }

  const FEdgeInsetsDirectional.fromSTEB(this.start,
      this.top,
      this.end,
      this.bottom,);

  const FEdgeInsetsDirectional.only({
    this.start = 0.0,
    this.top = 0.0,
    this.end = 0.0,
    this.bottom = 0.0,
  });

  const FEdgeInsetsDirectional.symmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  })
      : start = horizontal,
        end = horizontal,
        top = vertical,
        bottom = vertical;

  const FEdgeInsetsDirectional.all(double value)
      : start = value,
        top = value,
        end = value,
        bottom = value;

  final double start;
  final double top;
  final double end;
  final double bottom;

  @override
  EdgeInsetsDirectional get parse {
    return EdgeInsetsDirectional.only(
      start: start,
      end: end,
      top: top,
      bottom: bottom,
    );
  }
}
