import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  

  onButtonClick(value) {
    //if value=AC
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;

        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
      }
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //input/output area
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: 34,
                    color: Color.fromARGB(161, 255, 255, 255),
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 20,
          ),

          //button-------------------
          Row(
            children: [
              button(
                  text: "AC",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
              button(
                  text: "<",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
              button(text: "", butttonBgColor: Colors.transparent),
              button(
                text: "/",
                butttonBgColor: operatorColor,
                tcolor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "%",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
              button(text: "0"),
              button(
                  text: ".",
                  butttonBgColor: operatorColor,
                  tcolor: orangeColor),
              button(
                  text: "=",
                  butttonBgColor: Colors.orange,
                  tcolor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, butttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: butttonBgColor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
