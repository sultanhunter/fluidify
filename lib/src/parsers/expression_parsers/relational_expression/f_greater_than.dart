import '../expression.dart';

class FGreaterThan implements Expression {
  FGreaterThan(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  bool evaluate() {
    return (lhs.evaluate() as double) > (rhs.evaluate() as double);
  }
}
