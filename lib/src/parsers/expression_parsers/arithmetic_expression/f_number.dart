import '../expression.dart';

class FNumber extends Expression {
  FNumber(this.value);

  final double value;

  @override
  double evaluate() {
    return value;
  }
}
