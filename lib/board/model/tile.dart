import 'package:learncanvas/board/model/position.dart';

class Tile {
  final int value;
  final Position position;
  final Position correctPosition;

  const Tile({
    required this.value,
    required this.position,
    required this.correctPosition,
  });

  Tile move(Position newPosition) {
    return Tile(
      value: value,
      position: newPosition,
      correctPosition: correctPosition,
    );
  }
}
