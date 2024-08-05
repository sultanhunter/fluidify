import '../expression.dart';

class FIsNotNull extends Expression {
  FIsNotNull(this.lhs);

  final Expression lhs;

  @override
  bool evaluate() {
    return lhs.evaluate() != null;
  }
}
