import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

class Logic extends ChangeNotifier {
  Logic() {
    init();
  }
  int second = 0;
  int minute = 0;
  int height = 20;
  int width = 20;
  int hr = 0;
  double smokeFactor = Random().nextInt(15).toDouble();
  Timer? timer;
  bool gameStart = false;
  void increaseCounter() {
    second++;
    if (second == 60) {
      second = 0;
      minute++;
    }
    if (minute == 60) {
      hr++;
    }
    notifyListeners();
  }

  void init() {
    numbers.shuffle();

    notifyListeners();
  }

  void startGame() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      increaseCounter();
    });
    gameStart = true;
    notifyListeners();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void makeNew() {
    moves = 0;
    second = 0;
    minute = 0;
    height = 200;
    width = 200;
    hr = 0;
    numbers.shuffle();
    notifyListeners();
  }

  int moves = 0;
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  String gamestatus = '';

  void onClick(index) {
    if (index - 1 > 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      numbers[numbers.indexOf(0)] = numbers[index];
      numbers[index] = 0;
      moves++;
      smokeFactor =
          Random(DateTime.now().millisecondsSinceEpoch).nextInt(50).toDouble();
      notifyListeners();
      if (checkForWin(numbers)) {
        gamestatus = "Game Over";
        notifyListeners();
      }
    }
  }

  bool checkForWin(List numberl) {
    int first = numberl.first;
    for (int i = 1; i < numberl.length; i++) {
      int nextNumber = numberl[i];
      if (first > nextNumber) return false;
      first = numberl[i];
    }
    return true;
  }
}
