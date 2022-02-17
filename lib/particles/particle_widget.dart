import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learncanvas/particles/paint_canvas.dart';
import 'package:learncanvas/particles/particles.dart';

class ParticleWidget extends StatefulWidget {
  const ParticleWidget({Key? key}) : super(key: key);

  @override
  _ParticleWidgetState createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<ParticleWidget>
    with SingleTickerProviderStateMixin {
  late List<Particles> particles;
  Color giveMeAColor(Random rand) {
    // var a = rand.nextInt(255);
    // var r = rand.nextInt(255);
    // var g = rand.nextInt(255);
    // var b = rand.nextInt(255);
    return Colors.blue.withOpacity(rand.nextDouble());
  }

  List<Color> giveIngradients(Random rand) {
    return [
      Colors.blue.withOpacity(rand.nextDouble()),
      Colors.lightBlue.withOpacity(rand.nextDouble()),
    ];
  }

  Random rand = Random(DateTime.now().millisecondsSinceEpoch);

  double maxRadius = 4;
  double maxSpeed = 0.2;
  double maxTheta = 2.0 * pi;

  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    particles = List.generate(
      80,
      (index) => Particles(
          giveMeAColor(rand),
          giveIngradients(rand),
          rand.nextDouble() * maxRadius,
         const Offset(-1, -1),
          rand.nextDouble() * maxSpeed,
          rand.nextDouble() * maxTheta),
    );

    animationController = AnimationController(
        duration:const Duration(milliseconds: 2300), vsync: this);
    animation = Tween<double>(begin: 2, end: 10).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustomCanvas(
        particles: particles,
        rgn: rand,
        animationValue: animation.value,
      ),
    );
  }
}
