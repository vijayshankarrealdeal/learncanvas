import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board/game_controller.dart';
import 'package:learncanvas/board/game_state.dart';
import 'package:learncanvas/plaform/devices.dart';
import 'package:provider/provider.dart';

class GameButton extends StatelessWidget {
  const GameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final state = controller.state;

    return SizedBox(
      width: PuzzlePlatform.kwidthButton(context),
      child: CupertinoButton(
        color: state.status != GameStatus.created
            ? CupertinoColors.activeBlue.withOpacity(0.05)
            : CupertinoColors.activeBlue.withOpacity(0.25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.status != GameStatus.created
                ? const Icon(
                    CupertinoIcons.restart,
                    color: Colors.white,
                    size: 15,
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: 4),
            Text(
              state.status == GameStatus.created ? "Start" : "Reset",
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontFamily: 'SFMedium',
                    color: Colors.white,
                  ),
            ),
          ],
        ),
        onPressed: () => controller.shuffle(),
      ),
    );
  }
}
