import '../expression.dart';

// {
//   'type':'subtraction',
//   'data':{
//     'lhs': 10,
//     'rhs': 20,
//   }
// }

class FSubtraction extends Expression {
  FSubtraction(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  double evaluate() {
    return (lhs.evaluate() as double) - (rhs.evaluate() as double);
  }
}
