import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/board/game_controller.dart';
import 'package:learncanvas/dynamics/fan_dynmics_home.dart';
import 'package:learncanvas/new_smoke/fire_smoke.dart';
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
            image: AssetImage('assets/images/back.png'),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.rotate(
                  angle: pi / 1.6,
                  child: Transform.translate(
                    offset: Offset(MediaQuery.of(context).size.width * 0.26,
                        MediaQuery.of(context).size.height * 0.88),
                    child: const FIRESMOKE(
                        smokeFactor: 20,
                        gillterFactor: 100,
                        lifeAlpha: 100,
                        lifeFactor: 120,
                        radiusAlpha: 50,
                        radiusFactor: 200,
                        speedAplhaX: -3,
                        speedAlphaY: -14,
                        speedFactorX: 12,
                        speedFactorY: 12),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.rotate(
                  angle: 2 * pi / 1.6,
                  child: Transform.translate(
                    offset: Offset(-MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.88),
                    child: const FIRESMOKE(
                        smokeFactor: 20,
                        gillterFactor: 100,
                        lifeAlpha: 100,
                        lifeFactor: 120,
                        radiusAlpha: 30,
                        radiusFactor: 300,
                        speedAplhaX: -3,
                        speedAlphaY: -14,
                        speedFactorX: 12,
                        speedFactorY: 12),
                  ),
                ),
              ),

              Container(width: double.infinity),
              const Center(child: FanDynamics()),
              const SmokeWidgetHome(),
              const ParticleWidgetHome(),
              // Transform.translate(
              //   offset: Offset(-MediaQuery.of(context).size.width * 0.45,
              //       MediaQuery.of(context).size.height * 0.2),
              //   child: const Align(
              //     alignment: Alignment.bottomCenter,
              //     child: FIRESMOKE(
              //         smokeFactor: 10,
              //         gillterFactor: 100,
              //         lifeAlpha: 20,
              //         lifeFactor: 20,
              //         radiusAlpha: 10,
              //         radiusFactor: 30,
              //         speedAplhaX: -5,
              //         speedAlphaY: -15,
              //         speedFactorX: 10,
              //         speedFactorY: 10),
              //   ),
              // ),
              // Transform.translate(
              //   offset: Offset(MediaQuery.of(context).size.width * 0.45,
              //       MediaQuery.of(context).size.height * 0.2),
              //   child: const Align(
              //     alignment: Alignment.bottomCenter,
              //     child: FIRESMOKE(
              //         smokeFactor: 10,
              //         gillterFactor: 100,
              //         lifeAlpha: 10,
              //         lifeFactor: 20,
              //         radiusAlpha: 10,
              //         radiusFactor: 30,
              //         speedAplhaX: -5,
              //         speedAlphaY: -15,
              //         speedFactorX: 10,
              //         speedFactorY: 10),
              //   ),
              // ),
              const Center(child: NumDial()),
            ],
          ),
        ),
      )),
    );
  }

  void _showWinnerDialog(BuildContext context, int moves, int time) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(MediaQuery.of(context).size.width * 0.25,
                        MediaQuery.of(context).size.height * 0.7),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: FIRESMOKE(
                          smokeFactor: 20,
                          gillterFactor: 100,
                          lifeAlpha: 100,
                          lifeFactor: 120,
                          radiusAlpha: 5,
                          radiusFactor: 2,
                          speedAplhaX: -3,
                          speedAlphaY: -14,
                          speedFactorX: 12,
                          speedFactorY: 12),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-MediaQuery.of(context).size.width * 0.35,
                        MediaQuery.of(context).size.height * 0.7),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: FIRESMOKE(
                          smokeFactor: 20,
                          gillterFactor: 100,
                          lifeAlpha: 100,
                          lifeFactor: 120,
                          radiusAlpha: 5,
                          radiusFactor: 2,
                          speedAplhaX: -3,
                          speedAlphaY: -14,
                          speedFactorX: 12,
                          speedFactorY: 12),
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
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SFMedium',
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          "Moves: " + moves.toString(),
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontFamily: 'SFMedium',
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          "Duration: " + parseTime(time),
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontFamily: 'SFMedium',
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoButton(
                          color: CupertinoColors.activeBlue.withOpacity(0.02),
                          child: Text(
                            "New Game",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
