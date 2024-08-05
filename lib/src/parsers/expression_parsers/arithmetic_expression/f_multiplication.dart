import '../expression.dart';

// {
//   'type':'multiplication',
//   'value':{
//     'lhs': 10,
//     'rhs': 20,
//   }
// }
class FMultiplication extends Expression {
  FMultiplication(this.lhs, this.rhs);

  final Expression lhs;
  final Expression rhs;

  @override
  double evaluate() {
    return (lhs.evaluate() as double) * (rhs.evaluate() as double);
  }
}
