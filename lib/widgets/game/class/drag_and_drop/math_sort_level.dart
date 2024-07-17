import 'dart:math';

import 'package:beanmind_flutter/widgets/game/class/drag_and_drop/math_sort_user.dart';

List<int> upper = [];
List<int> lower = [];
List<int> startLower = [];

final Set<int> uniqueNumbers = {};
final Random random = Random();
String sortingOrder = '';

void randomNumber() {
  while (uniqueNumbers.length < 10) {
    uniqueNumbers.add(random.nextInt(99) + 1);
  }
  startLower.addAll(uniqueNumbers);
  lower = startLower;
}

void resetGameSortNumber() {
  upper.clear();
  lower.clear();
  startLower.clear();
  uniqueNumbers.clear();
  randomNumber();
}

void generateSortingQuestion() {
  bool isAscending = Random().nextBool();
  if (isAscending) {
    question = 'Sắp xếp dãy số theo thứ tự tăng dần';
    sortingOrder = 'ascending';
  } else {
    question = 'Sắp xếp dãy số theo thứ tự giảm dần';
    sortingOrder = 'descending';
  }
}
