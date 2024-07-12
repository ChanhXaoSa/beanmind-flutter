import 'dart:math';

import 'package:beanmind_flutter/game/class/happy_farm/happy_farm_user.dart';

int currentLevel = 1;
String currentQuestionType =
    ''; // To track if the question is about chickens or ducks
String currentQuestionOperator = '';

void generateQuestion() {
  if (currentLevel == 1) {
    // Level 1: Only counting questions
    if (Random().nextBool()) {
      currentQuestionType = 'chicken';
      question = 'Có bao nhiêu con gà?';
    } else {
      currentQuestionType = 'duck';
      question = 'Có bao nhiêu con vịt?';
    }
  } else if (currentLevel == 2) {
    // Level 2: Addition and Subtraction
    currentQuestionOperator = getRandomOperatorLevel2();
    question = 'Số lượng con gà $currentQuestionOperator con vịt là ';
  } else if (currentLevel == 3) {
    // Level 3: Addition, Subtraction, Multiplication, and Division
    currentQuestionOperator = getRandomOperatorLevel3();
    question = 'Số lượng con gà $currentQuestionOperator con vịt là ';
  }
}

String getRandomOperatorLevel2() {
  List<String> operators = ['+', '-'];
  return operators[Random().nextInt(operators.length)];
}

String getRandomOperatorLevel3() {
  List<String> operators = ['+', '-', '*', '/'];
  return operators[Random().nextInt(operators.length)];
}

int calculateAnswerLevel2(int num1, int num2, String operator) {
  switch (operator) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    default:
      throw ArgumentError('Invalid operator for Level 2');
  }
}

int calculateAnswerLevel3(int num1, int num2, String operator) {
  switch (operator) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    case '*':
      return num1 * num2;
    case '/':
      return num1 ~/ num2;
    default:
      throw ArgumentError('Invalid operator for Level 3');
  }
}
