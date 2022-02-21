import 'package:learncanvas/board/model/puzzle.dart';

enum GameStatus {
  created,
  playing,
  solved,
}

class GameState {
  final int crossAxisCount;
  final Puzzle puzzle;
  final bool solved;
  final int moves;
  final GameStatus status;
  const GameState({
    required this.status,
    required this.moves,
    required this.solved,
    required this.crossAxisCount,
    required this.puzzle,
  });

  GameState copyWith({
    int? crossAxisCount,
    Puzzle? puzzle,
    bool? solved,
    int? moves,
    GameStatus? status,
  }) {
    return GameState(
      status: status ?? this.status,
      moves: moves ?? this.moves,
      solved: solved ?? this.solved,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      puzzle: puzzle ?? this.puzzle,
    );
  }
}
