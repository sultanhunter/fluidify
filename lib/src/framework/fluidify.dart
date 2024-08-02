import '../action_parsers/fluidify_action_parser.dart';
import '../parsers/fluidify_parser.dart';
import 'fluidify_registry.dart';

class Fluidify{

  void initialize(){
    final parsers = <FluidifyParser<dynamic>>[];
    final actionParsers = <FluidifyActionParser<dynamic>>[];

    FluidifyRegistry.instance.registerAllParsers(parsers);
    FluidifyRegistry.instance.registerAllActions(actionParsers);
  }
}
