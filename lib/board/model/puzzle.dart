import 'package:learncanvas/board/model/position.dart';
import 'package:learncanvas/board/model/tile.dart';
import 'dart:math' as math;

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

  Puzzle shuffle() {
    final values = List.generate(
      tiles.length,
      (index) => index + 1,
    );
    values.add(0);
    values.shuffle();

    // [1,2,3,4,5,6,7,8,9,0] => [1,3,4,0,5,7,8,9,2,6]

    if (_isSolvable(values)) {
      int x = 1, y = 1;
      late Position emptyPosition;
      final copy = [...tiles];
      final int crossAxisCount = math.sqrt(values.length).toInt();

      for (int i = 0; i < values.length; i++) {
        final value = values[i];
        final position = Position(x: x, y: y);
        if (value == 0) {
          emptyPosition = position;
        } else {
          copy[value - 1] = copy[value - 1].move(
            position,
          );
        }

        if ((i + 1) % crossAxisCount == 0) {
          y++;
          x = 1;
        } else {
          x++;
        }
      }
      return Puzzle(
        tiles: copy,
        emptyPositon: emptyPosition,
      );
    } else {
      return shuffle();
    }
  }

  bool isSolved() {
    final crossAxisCount = math.sqrt(tiles.length + 1).toInt();
    if (emptyPositon.x == crossAxisCount && emptyPositon.y == crossAxisCount) {
      for (final tile in tiles) {
        if (tile.position != tile.correctPosition) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool _isSolvable(List<int> values) {
    final n = math.sqrt(values.length);

    /// inversions
    int inversions = 0;
    int y = 1;
    int emptyPositionY = 1;

    for (int i = 0; i < values.length; i++) {
      if (i > 0 && i % n == 0) {
        y++;
      }

      final current = values[i];
      if (current == 1 || current == 0) {
        if (current == 0) {
          emptyPositionY = y;
        }
        continue;
      }
      for (int j = i + 1; j < values.length; j++) {
        final next = values[j];

        if (current > next && next != 0) {
          inversions++;
        }
      }
    }

    // is odd
    if (n % 2 != 0) {
      return inversions % 2 == 0;
    } else {
      // is even

      final yFromBottom = n - emptyPositionY + 1;

      if (yFromBottom % 2 == 0) {
        return inversions % 2 != 0;
      } else {
        return inversions % 2 == 0;
      }
    }
  }
}
