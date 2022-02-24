import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:learncanvas/board/game_state.dart';
import 'package:learncanvas/board/model/puzzle.dart';
import 'package:learncanvas/board/model/tile.dart';

class GameController extends ChangeNotifier {
  GameState _state = GameState(
    crossAxisCount: 3,
    puzzle: Puzzle.create(3),
    solved: false,
    moves: 0,
    status: GameStatus.created,
  );

  final ValueNotifier<int> time = ValueNotifier(0);
  final StreamController<void> _streamController = StreamController.broadcast();
  Stream<void> get onFinish => _streamController.stream;

  Timer? _timer;

  GameState get state => _state;
  Puzzle get puzzle => _state.puzzle;

  void onTileTapped(Tile tile) {
    final canMove = puzzle.canMove(tile.position);
    if (canMove) {
      final newPuzzle = puzzle.move(tile);
      final solved = newPuzzle.isSolved(tile);
      _state = state.copyWith(
        puzzle: newPuzzle,
        moves: state.moves + 1,
        status: solved ? GameStatus.solved : state.status,
      );
      notifyListeners();
      if (solved) {
        _timer?.cancel();
        _streamController.sink.add(null);
      }
    }
  }

  Future<void> changeGrid(
    int crossAxisCount,
  ) async {
    _timer?.cancel();
    time.value = 0;

    /// reset the game with a new puzzle
    final newState = GameState(
      crossAxisCount: crossAxisCount,
      puzzle: Puzzle.create(
        crossAxisCount,
      ),
      solved: false,
      moves: 0,
      status: GameStatus.created,
    );
    _state = newState;
    notifyListeners();
  }

  void shuffle() {
    if (_timer != null) {
      time.value = 0;
      _timer!.cancel();
    }
    _state = state.copyWith(
      puzzle: puzzle.shuffle(),
      status: GameStatus.playing,
      moves: 0,
    );
    notifyListeners();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        time.value++;
      },
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _timer?.cancel();
    super.dispose();
  }
}
