import '../expression.dart';

class FIsNull extends Expression {
  FIsNull(this.lhs);

  final Expression lhs;

  @override
  bool evaluate() {
    return lhs.evaluate() == null;
  }
}
