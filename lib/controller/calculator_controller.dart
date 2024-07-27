import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class CalculatorController {
  ValueNotifier<String> displayText = ValueNotifier<String>('0');
  ValueNotifier<String> expressionText = ValueNotifier<String>('');

  late double v1;
  late double v2;
  late String a1;
  bool _shouldClearDisplay = false;
  String get dtext => displayText.value;
  String get etext => expressionText.value;

  void nextstep(String input) {
    if (opearator(input)) {
      a1 = input;
      v1 = double.tryParse(dtext)!;
      _shouldClearDisplay = true;
      expressionText.value = dtext + ' ' + a1;
    } else if (input == '=') {
      v2 = double.tryParse(dtext)!;

      _calculateResult();
    } else {
      if (_shouldClearDisplay) {
        displayText.value = input;
        _shouldClearDisplay = false;
      } else {
        displayText.value = dtext == '0' ? input : dtext + input;
      }
      expressionText.value += input;
    }
    _evaluateExpression();
  }

  bool opearator(String input) {
    return input == '+' || input == '-' || input == 'x' || input == '/';
  }

  void _calculateResult() {
    double result;

    switch (a1) {
      case '+':
        result = v1 + v2;
        break;
      case '-':
        result = v1 - v2;
        break;
      case 'x':
        result = v1 * v2;
        break;
      case '/':
        result = v1 / v2;
        break;
      default:
        return;
    }
    displayText.value = result.toString();

    expressionText.value += ' = ' + result.toString();
  }

  void clear() {
    displayText.value = '0';
    expressionText.value = '';
  }

  void _evaluateExpression() {
    try {
      final expression = Expression.parse(
          expressionText.value.replaceAll('x', '*').replaceAll(' ', ''));
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      displayText.value = result.toString();
    } catch (e) {
      displayText.value = '';
    }
  }
}
