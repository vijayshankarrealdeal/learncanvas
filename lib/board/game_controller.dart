import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:learncanvas/board/game_state.dart';
import 'package:learncanvas/board/model/puzzle.dart';
import 'package:learncanvas/board/model/tile.dart';

class GameController extends ChangeNotifier {
  GameController() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      increaseCounter();
    });
  }
  GameState _gameState = GameState(
    moves: 0,
    solved: false,
    crossAxisCount: 4,
    puzzle: Puzzle.create(4),
  );
  GameState get state => _gameState;
  Puzzle get puzzle => _gameState.puzzle;

  int moves = 0;
  int second = 0;
  int minute = 0;
  int height = 20;
  int width = 20;
  int hr = 0;
  Timer? timer;
 // bool gameStart = false;
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

  // void makeNew() {
  //   moves = 0;
  //   second = 0;
  //   minute = 0;
  //   height = 200;
  //   width = 200;
  //   hr = 0;
  //   puzzle.tiles.shuffle();
  //   notifyListeners();
  // }

  void onTileTapped(Tile tile) {
    final canMove = puzzle.canMove(tile.position);
    if (canMove) {
      _gameState = state.copyWith(
        puzzle: puzzle.move(tile),
      );
      moves++;
      notifyListeners();
    }
  }
}
