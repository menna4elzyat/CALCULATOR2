

import 'package:calculatorwithbloc/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

import 'cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorCubit(),
      child: CalculatorView(),
    );
  }
}



