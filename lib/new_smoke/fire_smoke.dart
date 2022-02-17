import 'dart:math';

import 'package:flutter/material.dart';

class KeyFrames {
  late Offset speed;
  late Offset location;
  late double radius;
  late double life;
  late Color color;
  late double opacity;

  late double remainingLife;
  late Size screenSize;
  var palette = <Color>[];
  KeyFrames(Size screenSize) {
    Random rd = Random();
    screenSize = screenSize;
    speed = Offset(-5 + rd.nextDouble() * 10, -15.0 + rd.nextDouble() * 10);
    location = Offset(screenSize.width / 2, screenSize.height / 3 * 2);
    //Flame or Smoke
    radius = 10 + rd.nextDouble() * 30;
    //Make More longer
    life = 20 + rd.nextDouble() * 20;
    remainingLife = life;
    for (int i = 5; i < 70; i++) {
      palette.add(HSLColor.fromAHSL(1, 227, 1, i / 100).toColor());
    }
    color = palette[0];
  }
  move() {
    remainingLife--;
    radius--;
    location = location + speed;
    int colorI =
        palette.length - (remainingLife / life * palette.length).round();
    if (colorI >= 0 && colorI < palette.length) {
      color = palette[colorI];
    }
  }

  display(Canvas canvas) {
    opacity = (remainingLife / life * 100).round() / 100;
    var gradient = RadialGradient(
      colors: [
        Color.fromRGBO(color.red, color.green, color.blue, opacity),
        Color.fromRGBO(color.red, color.green, color.blue, opacity),
        Color.fromRGBO(color.red, color.green, color.blue, 0.0)
      ],
      stops: const [0.0, 0.2, 1.0],
    );

    Paint painter = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient
          .createShader(Rect.fromCircle(center: location, radius: radius));

    canvas.drawCircle(location, radius, painter);
  }
}

class FIRESMOKE extends StatefulWidget {
  const FIRESMOKE({Key? key}) : super(key: key);

  @override
  _FIRESMOKEState createState() => _FIRESMOKEState();
}

class _FIRESMOKEState extends State<FIRESMOKE> with TickerProviderStateMixin {
  late AnimationController animationController;
  final Size sizeOfScreen = const Size(100, 100);
  late List<KeyFrames> particleSystem;
  Random rand = Random(DateTime.now().millisecondsSinceEpoch);
  late List<KeyFrames> l;

  @override
  void initState() {
    particleSystem = List.generate(300, (i) => KeyFrames(sizeOfScreen));
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        for (int i = 0; i < particleSystem.length; i++) {
          // Move particle
          particleSystem[i].move();

          // Restored particle
          if (particleSystem[i].remainingLife < 0 ||
              particleSystem[i].radius < 0) {
            particleSystem[i] = KeyFrames(sizeOfScreen);
          }
        }
      })
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => CustomPaint(
        size: sizeOfScreen,
        painter: _DemoPainter(particleSystem, sizeOfScreen),
      ),
    );
  }
}

class _DemoPainter extends CustomPainter {
  final List<KeyFrames> l;
  final Size screenSize;
  _DemoPainter(this.l, this.screenSize);
  Offset ploarDistance(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var particles in l) {
      particles.display(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
