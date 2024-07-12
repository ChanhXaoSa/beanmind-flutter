import 'dart:math';

import 'package:beanmind_flutter/game/class/ocean_adventure/ocean_adventure_user.dart';

int currentLevel = 2;
String currentQuestionType = ''; // To track the type of animal
String currentQuestionOperator = '';
int randomIndex = 0;
List<String> animals = [
  'bluefish',
  'redfish',
  'violetfish',
  'moonfish',
  'octopus'
];

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
    // Level 2: Addition and Subtraction with different animal types
    String animal1 = animals[Random().nextInt(animals.length)];
    String animal2 = animals[Random().nextInt(animals.length)];
    while (animal1 == animal2) {
      animal2 = animals[Random().nextInt(animals.length)];
    }
    currentQuestionOperator = getRandomOperatorLevel2();
    question =
        'Số lượng $animal1 $currentQuestionOperator số lượng $animal2 là ';
  } else if (currentLevel == 3) {
    // Level 3: Addition, Subtraction, Multiplication, and Division with different animal types
    String animal1 = animals[Random().nextInt(animals.length)];
    String animal2 = animals[Random().nextInt(animals.length)];
    while (animal1 == animal2) {
      animal2 = animals[Random().nextInt(animals.length)];
    }
    currentQuestionOperator = getRandomOperatorLevel3();
    question =
        'Số lượng $animal1 $currentQuestionOperator số lượng $animal2 là ';
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
      if (num2 == 0) {
        throw ArgumentError('Division by zero is not allowed');
      }
      return num1 ~/ num2;
    default:
      throw ArgumentError('Invalid operator for Level 3');
  }
}
