import 'dart:math';

import 'package:beanmind_flutter/widgets/game/class/math_game/math_game_user.dart';

int? firstValue;
int? secondValue;
String? operator;
int? correctAnswer;
List<int> choice = [];
bool isAnswered = false;
bool isCorrect = false;
String currentQuestionType = '';
String currentQuestionOperator = '';

restartGame() {
  getRandomValue();
  operator = getRandomOperator();
  correctAnswer = calculateAnswer(firstValue!, secondValue!, operator!);
  choice.clear();
  choice.add(correctAnswer!);
  choice.add(Random().nextInt(100));
  choice.add(Random().nextInt(100));
  choice.shuffle();
  userPoint = 0;
  userProgress = 0;
}

nextQuestion() {
  getRandomValue();
  operator = getRandomOperator();
  correctAnswer = calculateAnswer(firstValue!, secondValue!, operator!);
  choice.clear();
  choice.add(correctAnswer!);
  choice.add(Random().nextInt(100));
  choice.add(Random().nextInt(100));
  choice.shuffle();
}

String getRandomOperator() {
  List<String> operators = [
    '+',
    '-',
    // '*',
    // '/',
  ];
  return operators[Random().nextInt(operators.length)];
}

int calculateAnswer(int num1, int num2, String operator) {
  switch (operator) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    // case '*':
    //   return num1 * num2;
    // case '/':
    //   return num1 ~/ num2;
    default:
      throw ArgumentError('Invalid operator');
  }
}

getRandomValue() {
    firstValue = Random().nextInt(50) + 5;
    secondValue = Random().nextInt(firstValue!);
}
