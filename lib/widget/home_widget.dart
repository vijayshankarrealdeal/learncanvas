import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board_logic.dart';
import 'package:learncanvas/particles/particle_widget.dart';
import 'package:learncanvas/plaform/devices.dart';
import 'package:learncanvas/plaform/text.dart';
import 'package:learncanvas/smoke/smoke_control.dart';
import 'package:learncanvas/smoke/smoke_widget.dart';
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
    return Consumer<Logic>(builder: (context, blogic, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${blogic.moves} Moves',
                    style: PuzzleText.kHeadingText(context)),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text('${blogic.numbers.length - 1} Tiles',
                    style: PuzzleText.kHeadingText(context)),
              ],
            ),
          ),
          SizedBox(
              height: PuzzlePlatform.kheightBoard(context),
              width: PuzzlePlatform.kheightBoard(context),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: PuzzlePlatform.kaspectRationBoard(context),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (ctx, index) {
                  return blogic.numbers[index] != 0
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          clipBehavior: Clip.antiAlias,
                          child: GestureDetector(
                            onTap: !blogic.gameStart
                                ? null
                                : () => blogic.onClick(index),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white.withOpacity(0.03),
                                ),
                                child: Center(
                                  child: Text(
                                    blogic.numbers[index].toString(),
                                    style: PuzzleText.kBoardNumber(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
                itemCount: blogic.numbers.length,
              )),
          SizedBox(
            width: PuzzlePlatform.kwidthButton(context),
            child: CupertinoButton(
              color: blogic.gameStart
                  ? CupertinoColors.activeBlue.withOpacity(0.16)
                  : CupertinoColors.activeBlue.withOpacity(0.25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blogic.gameStart
                      ? const Icon(
                          CupertinoIcons.restart,
                          color: Colors.white,
                          size: 15,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 4),
                  Text(
                    blogic.gameStart ? 'Shuffle' : 'Start',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontFamily: 'SFMedium',
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              onPressed: () =>
                  blogic.gameStart ? blogic.makeNew() : blogic.startGame(),
            ),
          ),
          SizedBox(
            width: PuzzlePlatform.kwidthButton(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${blogic.hr}   : ',
                    style: PuzzleText.kTimerDigits(context)),
                const SizedBox(width: 3),
                Text('${blogic.minute}   : ',
                    style: PuzzleText.kTimerDigits(context)),
                const SizedBox(width: 5),
                Text('${blogic.second}',
                    style: PuzzleText.kTimerDigits(context)),
              ],
            ),
          ),
        ],
      );
    });
  }
}
