import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:learncanvas/smoke/smoke.dart';
import 'package:learncanvas/smoke/square.dart';

class SmokeCreateWidget extends StatefulWidget {
  final ui.Image img;
  final double angle;
  final bool repeatAlways;
  const SmokeCreateWidget(
      {Key? key,
      required this.repeatAlways,
      required this.angle,
      required this.img})
      : super(key: key);

  @override
  _SmokeCreateWidgetState createState() => _SmokeCreateWidgetState();
}

class _SmokeCreateWidgetState extends State<SmokeCreateWidget>
    with SingleTickerProviderStateMixin {
  /////Smoke
  late Animation<double> animationSmoke;
  late AnimationController controllerSmoke;
  late List<Square> sq;
  Random rand = Random(DateTime.now().millisecondsSinceEpoch);

  double giveMeSide(Random ran) {
    return ran.nextInt(1500).toDouble();
  }

  ///

  @override
  void initState() {
///////////
//Smoke
    sq = List.generate(
      1500,
      (index) => Square(
          theta: 0.7,
          speed: 0.2,
          side: giveMeSide(rand),
          position: Offset(
              rand.nextInt(200).toDouble(), rand.nextInt(200).toDouble())),
    );
    controllerSmoke = AnimationController(
        duration: const Duration(milliseconds: 6500), vsync: this);
    animationSmoke =
        CurvedAnimation(parent: controllerSmoke, curve: Curves.easeInOutCubic)

          //Tween<double>(begin: 0, end: 200).animate(controllerSmoke)
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controllerSmoke.stop();
            }
          });
    widget.repeatAlways ? controllerSmoke.repeat() : controllerSmoke.forward();
    super.initState();
////////////
  }

  @override
  void dispose() {
    controllerSmoke.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyBoxPainter(
          angle: widget.angle,
          sq: sq,
          rgn: rand,
          animation: animationSmoke.value,
          img: widget.img),
    );
  }
}
