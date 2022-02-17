import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board_logic.dart';
import 'package:learncanvas/particles/particle_widget.dart';
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
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${blogic.moves} Moves',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontFamily: 'SFMedium',
                        color: Colors.white,
                      ),
                ),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text(
                  '${blogic.numbers.length - 1} Tiles',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontFamily: 'SFMedium',
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
                height: Platform.isAndroid
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height * 0.54,
                width: Platform.isAndroid
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.width * 0.4,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: Platform.isAndroid
                        ? 1
                        : MediaQuery.of(context).size.aspectRatio * 0.75,
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
                                      style: Platform.isAndroid
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontFamily: 'SFMedium',
                                                fontSize: 28,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                                    .withOpacity(0.85),
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontFamily: 'SFMedium',
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                                    .withOpacity(0.85),
                                              ),
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
          ),
          SizedBox(
            width: Platform.isAndroid
                ? MediaQuery.of(context).size.height * 0.3
                : MediaQuery.of(context).size.width * 0.3,
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
            width: Platform.isAndroid
                ? MediaQuery.of(context).size.height * 0.3
                : MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${blogic.hr}   : ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontFamily: 'SFMedium',
                        color: Colors.white,
                      ),
                ),
                const SizedBox(width: 3),
                Text(
                  '${blogic.minute}   : ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontFamily: 'SFMedium',
                        color: Colors.white,
                      ),
                ),
                const SizedBox(width: 5),
                Text(
                  '${blogic.second}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontFamily: 'SFMedium',
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
