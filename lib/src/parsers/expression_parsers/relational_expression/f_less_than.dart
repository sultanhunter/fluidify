import '../expression.dart';

class FLessThan extends Expression {
  FLessThan(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  bool evaluate() {
    return (lhs.evaluate() as double) < (rhs.evaluate() as double);
  }
}
