import 'dart:math';

List<int> upper = [];
List<int> lower = [];
List<int> startLower = [];

final Set<int> uniqueNumbers = {};
final Random random = Random();

void randomNumber() {
  while (uniqueNumbers.length < 10) {
    uniqueNumbers.add(random.nextInt(99) + 1);
  }
  startLower.addAll(uniqueNumbers);
  lower.addAll(uniqueNumbers);
}

void resetGameSortNumber() {
  upper.clear();
  lower.clear();
  startLower.clear();
  uniqueNumbers.clear();
  randomNumber();
}
