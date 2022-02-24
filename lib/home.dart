import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board/game_controller.dart';
import 'package:learncanvas/dynamics/fan_dynmics_home.dart';
import 'package:learncanvas/new_smoke/fire_smoke.dart';
import 'package:learncanvas/particles/particle_widget.dart';
import 'package:learncanvas/plaform/devices.dart';
import 'package:learncanvas/widget/home_widget.dart';
import 'package:provider/provider.dart';

String parseTime(int time) {
  final duration = Duration(
    seconds: time,
  );
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$minutes : $seconds";
}

class MyPainter extends StatelessWidget {
  const MyPainter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameController>(
      create: (_) {
        final controller = GameController();
        controller.onFinish.listen(
          (_) {
            Timer(
              const Duration(
                milliseconds: 200,
              ),
              () {
                _showWinnerDialog(
                  context,
                  controller.state.moves,
                  controller.time.value,
                );
              },
            );
          },
        );
        return controller;
      },
      child: Scaffold(
          //appBar: AppBar(),
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/2.png'),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: pi / 1.6,
                child: Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width * 0.27,
                      MediaQuery.of(context).size.height * 0.36),
                  child: const FIRESMOKE(
                      smokeFactor: 20,
                      gillterFactor: 100,
                      lifeAlpha: 100,
                      lifeFactor: 120,
                      radiusAlpha: 50,
                      radiusFactor: 30,
                      speedAplhaX: -1,
                      speedAlphaY: -5,
                      speedFactorX: 2,
                      speedFactorY: 2),
                ),
              ),
            ),
            Container(width: double.infinity),
            const Center(child: FanDynamics()),
            const SmokeWidgetHome(),
            const ParticleWidgetHome(),
            Transform.translate(
              offset: Offset(-MediaQuery.of(context).size.width * 0.45,
                  MediaQuery.of(context).size.height * 0.2),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: FIRESMOKE(
                    smokeFactor: 10,
                    gillterFactor: 100,
                    lifeAlpha: 20,
                    lifeFactor: 20,
                    radiusAlpha: 10,
                    radiusFactor: 30,
                    speedAplhaX: -5,
                    speedAlphaY: -15,
                    speedFactorX: 10,
                    speedFactorY: 10),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.45,
                  MediaQuery.of(context).size.height * 0.2),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: FIRESMOKE(
                    smokeFactor: 10,
                    gillterFactor: 100,
                    lifeAlpha: 10,
                    lifeFactor: 20,
                    radiusAlpha: 10,
                    radiusFactor: 30,
                    speedAplhaX: -5,
                    speedAlphaY: -15,
                    speedFactorX: 10,
                    speedFactorY: 10),
              ),
            ),
            const Center(child: NumDial()),
          ],
        ),
      )),
    );
  }

  void _showWinnerDialog(BuildContext context, int moves, int time) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 23, sigmaY: 23),
          child: Dialog(
            backgroundColor: CupertinoColors.systemBlue.withOpacity(0.18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: PuzzlePlatform.kwidthButton(context),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(MediaQuery.of(context).size.width * 0.45,
                        MediaQuery.of(context).size.height * 0.2),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: FIRESMOKE(
                          smokeFactor: 20,
                          gillterFactor: 100,
                          lifeAlpha: 10,
                          lifeFactor: 20,
                          radiusAlpha: 10,
                          radiusFactor: 30,
                          speedAplhaX: -5,
                          speedAlphaY: -15,
                          speedFactorX: 10,
                          speedFactorY: 10),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-MediaQuery.of(context).size.width * 0.45,
                        MediaQuery.of(context).size.height * 0.2),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: FIRESMOKE(
                          smokeFactor: 20,
                          gillterFactor: 100,
                          lifeAlpha: 10,
                          lifeFactor: 20,
                          radiusAlpha: 10,
                          radiusFactor: 30,
                          speedAplhaX: -5,
                          speedAlphaY: -15,
                          speedFactorX: 10,
                          speedFactorY: 10),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Winner",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFMedium',
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          "Moves: " + moves.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontFamily: 'SFMedium',
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          "Duration: " + parseTime(time),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontFamily: 'SFMedium',
                                    color: Colors.white,
                                  ),
                        ),
                        CupertinoButton(
                          color: CupertinoColors.activeBlue.withOpacity(0.08),
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  fontFamily: 'SFMedium',
                                  color: Colors.white,
                                ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
