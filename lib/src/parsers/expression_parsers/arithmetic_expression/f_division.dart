import '../expression.dart';

// {
//   'type':'division',
//   'data':{
//     'numerator': 10,
//     'denominator': 20,
//   }
// }
class FDivision extends Expression {
  FDivision(this.numerator, this.denominator);

  final Expression numerator;
  final Expression denominator;

  @override
  double evaluate() {
    return (numerator.evaluate() as double) /
        (denominator.evaluate() as double);
  }
}
