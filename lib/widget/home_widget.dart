import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board/game_controller.dart';
import 'package:learncanvas/board/game_state.dart';
import 'package:learncanvas/board/puzzle_interact.dart';
import 'package:learncanvas/particles/particle_widget.dart';
import 'package:learncanvas/plaform/devices.dart';
import 'package:learncanvas/smoke/smoke_control.dart';
import 'package:learncanvas/smoke/smoke_widget.dart';
import 'package:learncanvas/widget/game_button.dart';
import 'package:learncanvas/widget/time_moves.dart';
import 'package:provider/provider.dart';

class SmokeWidgetHome extends StatelessWidget {
  const SmokeWidgetHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmokeX>(builder: (context, snapshot, _) {
      return snapshot.loadImage
          ? SizedBox(
              child: Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width * 0.5,
                    MediaQuery.of(context).size.height * 0.6),
                child: SmokeCreateWidget(
                    repeatAlways: false, angle: -5, img: snapshot.img!),
              ),
            )
          : const SizedBox();
    });
  }
}

class ParticleWidgetHome extends StatelessWidget {
  const ParticleWidgetHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: const ParticleWidget());
  }
}

class NumDial extends StatelessWidget {
  const NumDial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(builder: (context, blogic, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const TimesAndMoves(),
          SizedBox(
            height: PuzzlePlatform.kheightBoard(context),
            width: PuzzlePlatform.kheightBoard(context),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: PuzzleInteract(),
              ),
            ),
          ),
          const GameButton(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  Consumer<GameController>(builder: (context, controller, _) {
                return DropdownButton(
                  elevation: 12,
                  underline: const SizedBox.shrink(),
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.black,
                  focusColor: Colors.transparent,
                  dropdownColor: controller.state.status != GameStatus.created
                      ? CupertinoColors.activeBlue.withOpacity(0.8)
                      : CupertinoColors.activeBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontFamily: 'SFMedium',
                        color: Colors.white,
                      ),
                  items: [3, 4, 5]
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text("$e x $e"),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (crossAxisCount) {
                    if (crossAxisCount != null &&
                        crossAxisCount != controller.state.crossAxisCount) {
                      controller.changeGrid(crossAxisCount as int);
                    }
                  },
                  value: controller.state.crossAxisCount,
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
