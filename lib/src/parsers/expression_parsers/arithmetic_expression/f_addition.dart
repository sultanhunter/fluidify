import '../expression.dart';

// {
//   'type':'addition',
//   'data':{
//     'lhs': 10,
//     'rhs': 20,
//   }
// }

class FAddition extends Expression {
  FAddition(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  double evaluate() {
    return (lhs.evaluate() as double) + (rhs.evaluate() as double);
  }
}
