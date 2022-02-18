import 'package:learncanvas/board/model/puzzle.dart';


class GameState {
  final int crossAxisCount;
  final Puzzle puzzle;
  final bool solved;
  final int moves;
  const GameState({
    required this.moves,
    required this.solved,
    required this.crossAxisCount,
    required this.puzzle,
  });

  GameState copyWith(
      {int? crossAxisCount,
      Puzzle? puzzle,
      bool? solved,
      int? moves,
    }) {
    return GameState(
      moves: moves ?? this.moves,
      solved: solved ?? this.solved,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      puzzle: puzzle ?? this.puzzle,
    );
  }
}
