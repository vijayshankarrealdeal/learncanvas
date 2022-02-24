import 'package:flutter/material.dart';
import 'package:learncanvas/board/game_controller.dart';
import 'package:learncanvas/board/game_state.dart';
import 'package:learncanvas/board/puzzle_tile.dart';
import 'package:provider/provider.dart';

class PuzzleInteract extends StatelessWidget {
  const PuzzleInteract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: LayoutBuilder(builder: (context, constraints) {
        final controller = context.watch<GameController>();
        final state = controller.state;
        final tileSize = constraints.maxWidth / state.crossAxisCount;
        return AbsorbPointer(
          absorbing: state.status != GameStatus.playing,
          child: Stack(
            children: state.puzzle.tiles
                .map(
                  (e) => PuzzleTile(
                    tile: e,
                    onTap: () => controller.onTileTapped(e),
                    size: tileSize,
                  ),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
