import 'dart:math';

import 'package:beanmind_flutter/game/class/ocean_adventure/ocean_adventure_user.dart';

int currentLevel = 1;
String currentQuestionType =
    ''; // To track if the question is about chickens or ducks
String currentQuestionOperator = '';
int randomIndex = 0;

void generateQuestion() {
  randomIndex = Random().nextInt(5);
  if (currentLevel == 1) {
    switch (randomIndex) {
      case 0:
        currentQuestionType = 'bluefish';
        question = 'Có bao nhiêu con cá màu xanh dương ?';
        break;
      case 1:
        currentQuestionType = 'redfish';
        question = 'Có bao nhiêu con cá màu đỏ ?';
        break;
      case 2:
        currentQuestionType = 'violetfish';
        question = 'Có bao nhiêu con cá màu tím ?';
        break;
      case 3:
        currentQuestionType = 'moonfish';
        question = 'Có bao nhiêu con cá mặt trăng ?';
        break;
      case 4:
        currentQuestionType = 'octopus';
        question = 'Có bao nhiêu con bạch tuộc ?';
        break;
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
