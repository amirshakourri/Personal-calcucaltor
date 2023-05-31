import 'dart:math';

import 'package:calculators/constans.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var userGivingNumber = '';
  var result = '';

  // for buttom when pressed by user
  buttomPressed(String text) {
    setState(() {
      userGivingNumber = userGivingNumber + text;
    });
  }

  // display numbers and math operator in buttom container screen
  numAndOperators(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            if (text1 == "C") {
              setState(() {
                if (userGivingNumber.length > 0) {
                  userGivingNumber = userGivingNumber.substring(
                      0, userGivingNumber.length - 1);
                }
              });
            } else {
              buttomPressed(text1);
            }
          },
          child: Text(
            text1,
            style: TextStyle(fontSize: 30),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text2 == "AC") {
              setState(() {
                userGivingNumber = '';
                result = '';
              });
            } else {
              buttomPressed(text2);
            }
          },
          child: Text(
            text2,
            style: TextStyle(fontSize: 30),
          ),
        ),
        TextButton(
          onPressed: () {
            buttomPressed(text3);
          },
          child: Text(
            text3,
            style: TextStyle(fontSize: 30),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(userGivingNumber);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttomPressed(text4);
            }
          },
          child: Text(
            text4,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Calculator',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text('Converter'),
                      Text('Finance'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 100, 20, 0),
                        child: Text(
                          userGivingNumber,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 25, 18, 0),
                        child: Text(
                          result,
                          style: TextStyle(fontSize: 56),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  color: greyColor,
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numAndOperators("C", "AC", "%", "/"),
                      numAndOperators("1", "2", "3", "*"),
                      numAndOperators("4", "5", "6", "+"),
                      numAndOperators("7", "8", "9", "-"),
                      numAndOperators("00", "0", ".", "="),
                    ],
                  ),
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
