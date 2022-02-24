import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board/game_controller.dart';
import 'package:provider/provider.dart';

class TimesAndMoves extends StatelessWidget {
  const TimesAndMoves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<GameController>(context, listen: false).time;
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: time,
            builder: (_, time, icon) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.clock,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    parseTime(time),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontFamily: 'SFMedium',
                          color: Colors.white,
                        ),
                  ),
                ],
              );
            },
          ),
          const VerticalDivider(color: Colors.white),
          Selector<GameController, int>(
            builder: (_, moves, __) {
              return Text(
                "Moves: $moves",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontFamily: 'SFMedium',
                      color: Colors.white,
                    ),
              );
            },
            selector: (_, controller) => controller.state.moves,
          ),
        ],
      ),
    );
  }

  String parseTime(int time) {
    final duration = Duration(
      seconds: time,
    );
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes : $seconds";
  }
}
