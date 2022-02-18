import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learncanvas/board/model/tile.dart';
import 'package:learncanvas/plaform/text.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double size;
  final VoidCallback onTap;
  const PuzzleTile({
    Key? key,
    required this.onTap,
    required this.size,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
      left: (tile.position.x - 1) * size,
      top: (tile.position.y - 1) * size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: onTap,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white.withOpacity(0.06),
              ),
              child: Center(
                child: Text(
                  tile.value.toString(),
                  style: PuzzleText.kBoardNumber(context),
                ),
              ),
            ),
          ),
        ),

        // Container(
        //   margin: const EdgeInsets.all(8.0),
        //   color: Colors.white,
        //   height: size - 2,
        //   width: size - 2,
        //   alignment: Alignment.center,
        //   child: Text(
        //     tile.value.toString(),
        //   ),
      ),
    );
  }
}
