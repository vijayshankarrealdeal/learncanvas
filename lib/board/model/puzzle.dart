import 'package:learncanvas/board/model/position.dart';
import 'package:learncanvas/board/model/tile.dart';

class Puzzle {
  final List<Tile> tiles;
  final Position emptyPositon;
  const Puzzle({
    required this.tiles,
    required this.emptyPositon,
  });

  bool canMove(Position tilePosition) {
    if (tilePosition.x == emptyPositon.x || tilePosition.y == emptyPositon.y) {
      return true;
    }
    return false;
  }

  Puzzle move(Tile tile) {
    final copy = [...tiles];
    //left or right
    if (tile.position.y == emptyPositon.y) {
      final row = tiles.where(
        (e) => e.position.y == emptyPositon.y,
      );
      if (tile.position.x < emptyPositon.x) {
        for (final e in row) {
          if (e.position.x < tile.position.x || e.position.x > emptyPositon.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x + 1,
              y: e.position.y,
            ),
          );
        }
      } else {
        for (final e in row) {
          if (e.position.x > tile.position.x || e.position.x < emptyPositon.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x - 1,
              y: e.position.y,
            ),
          );
        }
      }
    } else {
      //top or bottom
      final column = tiles.where(
        (e) => e.position.x == emptyPositon.x,
      );
      if (tile.position.y < emptyPositon.y) {
        for (final e in column) {
          if (e.position.y > emptyPositon.y || e.position.y < tile.position.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y + 1,
            ),
          );
        }
      } else {
        for (final e in column) {
          if (e.position.y < emptyPositon.y || e.position.y > tile.position.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y - 1,
            ),
          );
        }
      }
    }
    return Puzzle(
      tiles: copy,
      emptyPositon: tile.position,
    );
  }

  factory Puzzle.create(int crossAxisCount) {
    int value = 1;
    final List<Tile> _tiles = [];
    final emptyPosition = Position(x: crossAxisCount, y: crossAxisCount);
    for (int i = 1; i <= crossAxisCount; i++) {
      for (int j = 1; j <= crossAxisCount; j++) {
        final add = (i == crossAxisCount && j == crossAxisCount);
        if (!add) {
          final position = Position(x: i, y: j);
          final tile = Tile(
            value: value,
            position: position,
            correctPosition: position,
          );
          _tiles.add(tile);
          value++;
        }
      }
    }
    return Puzzle(
      tiles: _tiles,
      emptyPositon: emptyPosition,
    );
  }
}
