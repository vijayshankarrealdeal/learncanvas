import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learncanvas/dynamics/fan_dynmics_home.dart';
import 'package:learncanvas/new_smoke/fire_smoke.dart';
import 'package:learncanvas/widget/home_widget.dart';

class MyPainter extends StatelessWidget {
  const MyPainter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Transform.rotate(
          //   angle: pi / 24,
          //   child: Transform.translate(
          //     offset: Offset(0, MediaQuery.of(context).size.height * 0.2),
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: AnimatedBuilder(
          //         animation: animationController,
          //         builder: (context, child) => CustomPaint(
          //           size: sizeOfScreen,
          //           painter: _DemoPainter(particleSystem, sizeOfScreen),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

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
          const Center(child: NumDial()),
        ],
      ),
    ));
  }
}
