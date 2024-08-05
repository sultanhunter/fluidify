import '../expression.dart';

class FNotEqual implements Expression {
  FNotEqual(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  bool evaluate() {
    return lhs.evaluate() != rhs.evaluate();
  }
}
