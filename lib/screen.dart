import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

import 'cubit.dart';
class CalculatorView extends StatelessWidget {
  CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var calBloc = BlocProvider.of<CalculatorCubit>(context);
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.bottomRight,
              child: BlocBuilder<CalculatorCubit, CalState>(
                builder: (context, state) {
                  if (state is EquationUpdated) {
                    return Text(
                      state.equation,
                      style: TextStyle(color: Colors.white, fontSize: 48),
                    );
                  }
                  return Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 48),
                  );
                },
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [

                buttonRow(calBloc, ['C', '←', '%', '/']),
                buttonRow(calBloc, ['7', '8', '9', 'x']),
                buttonRow(calBloc, ['4', '5', '6', '-']),

                buttonRow(calBloc, ['1', '2', '3', '+']),

                buttonRow(calBloc, ['0', '.', '='], isZero: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonRow(CalculatorCubit calBloc, List<String> buttons, {bool isZero = false}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return CalculatorButton(
            text: button,
            onTap: () => calBloc.calculate(button),
            isZero: button == '0' && isZero,
          );
        }).toList(),
      ),
    );
  }
}