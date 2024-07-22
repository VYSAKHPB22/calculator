import 'package:flutter/material.dart';

import '../controller/calculator_controller.dart';
import '../widget/calculator_button.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final CalculatorController controller = new CalculatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('simple calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: controller.expressionText,
                    builder: (context, value, child) {
                      return Text(
                        value,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.grey),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.displayText,
                    builder: (context, value, child) {
                      return Text(
                        value,
                        style: const TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                buttonrow([
                  'C',
                ]),
                buttonrow(['7', '8', '9', 'x']),
                buttonrow(['4', '5', '6', '-']),
                buttonrow(['1', '2', '3', '+']),
                buttonrow(['0', '.', '=', ' /']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonrow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return CalculatorButton(
            text: button,
            onPressed: () {
              setState(() {
                if (button == 'C') {
                  controller.clear();
                } else {
                  controller.nextstep(button);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
