import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';
class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isZero;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isZero = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isZero ? 2 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
class CalculatorCubit extends Cubit<CalState> {
  CalculatorCubit() : super(InitialCalState());

  void calculate(String buttonText) {
    final currentState = state;
    if (currentState is EquationUpdated) {
      String newEquation = currentState.equation;

      switch (buttonText) {
        case 'C':
          newEquation = '0';
          break;
        case '←':
          newEquation = newEquation.length > 1 ? newEquation.substring(0, newEquation.length - 1) : '0';
          break;
        case '=':
          String finalExpression = newEquation.replaceAll('x', '*').replaceAll('÷', '/');

          Parser p = Parser();
          Expression exp = p.parse(finalExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          if (eval == eval.toInt().toDouble()) {
            newEquation = eval.toInt().toString();
          } else {
            newEquation = eval.toStringAsFixed(2);
          }
          break;
        default:
          if (newEquation == '0') {
            newEquation = buttonText;
          } else {
            newEquation += buttonText;
          }
          break;
      }

      emit(EquationUpdated(newEquation));
    } else {

      emit(EquationUpdated(buttonText == 'C' ? '0' : buttonText));
    }
  }
}


abstract class CalState {}

class InitialCalState extends CalState {}

class EquationUpdated extends CalState {
  final String equation;

  EquationUpdated(this.equation);
}