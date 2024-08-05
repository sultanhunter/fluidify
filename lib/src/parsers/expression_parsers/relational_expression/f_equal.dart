import '../expression.dart';

class FEqual implements Expression {
  FEqual(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  bool evaluate() {
    return lhs.evaluate() == rhs.evaluate();
  }
}
