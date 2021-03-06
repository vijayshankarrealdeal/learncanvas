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
  KeyFrames(
    Size screenSize,
    double lifeAlpha,
    double lifeFactor,
    double radiusAlpha,
    double radiusFactor,
    double speedAplhaX,
    double speedAlphaY,
    double speedFactorX,
    double speedFactorY,
  ) {
    Random rd = Random();
    screenSize = screenSize;
    speed = Offset(speedAplhaX + rd.nextDouble() * speedFactorX,
        speedAlphaY + rd.nextDouble() * speedFactorY);
    location = Offset(screenSize.width / 2, screenSize.height / 3 * 2);
    //Flame or Smoke
    radius = radiusAlpha + rd.nextDouble() * radiusFactor;
    radius = radius > 150 ? radius : 100;
    //Make More longer
    life = lifeAlpha + rd.nextDouble() * lifeFactor;
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

  display(Canvas canvas, double smokeFactor, double giltterFactor) {
    opacity = (remainingLife / life * smokeFactor).round() / giltterFactor;
    var gradient = RadialGradient(
      colors: [
        Color.fromRGBO(color.red, color.green, color.blue, opacity),
        Color.fromRGBO(color.red, color.green, color.blue, opacity),
        Color.fromRGBO(color.red, color.green, color.blue, 0.0)
      ],
      stops: const [0.0, 0.1, 1.0],
    );

    Paint painter = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient
          .createShader(Rect.fromCircle(center: location, radius: radius));

    canvas.drawCircle(location, radius, painter);
  }
}

class FIRESMOKE extends StatefulWidget {
  final double smokeFactor;
  final double gillterFactor;

  final double lifeAlpha;
  final double lifeFactor;
  final double radiusAlpha;
  final double radiusFactor;
  final double speedAplhaX;
  final double speedAlphaY;
  final double speedFactorX;
  final double speedFactorY;
  const FIRESMOKE(
      {Key? key,
      required this.smokeFactor,
      required this.gillterFactor,
      required this.lifeAlpha,
      required this.lifeFactor,
      required this.radiusAlpha,
      required this.radiusFactor,
      required this.speedAplhaX,
      required this.speedAlphaY,
      required this.speedFactorX,
      required this.speedFactorY})
      : super(key: key);

  @override
  _FIRESMOKEState createState() => _FIRESMOKEState();
}

class _FIRESMOKEState extends State<FIRESMOKE> with TickerProviderStateMixin {
  late AnimationController animationController;
  final Size sizeOfScreen = const Size(200, 200);
  late List<KeyFrames> particleSystem;
  Random rand = Random(DateTime.now().millisecondsSinceEpoch);
  late List<KeyFrames> l;
//Default Values = 20, 20, 10, 30, -5, -15, 10, 10
  @override
  void initState() {
    particleSystem = List.generate(
      300,
      (i) => KeyFrames(
          sizeOfScreen,
          widget.lifeAlpha,
          widget.lifeFactor,
          widget.radiusAlpha,
          widget.radiusFactor,
          widget.speedAplhaX,
          widget.speedAlphaY,
          widget.speedFactorX,
          widget.speedFactorY),
    );
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        for (int i = 0; i < particleSystem.length; i++) {
          // Move particle
          particleSystem[i].move();

          // Restored particle
          if (particleSystem[i].remainingLife < 0 ||
              particleSystem[i].radius < 0) {
            particleSystem[i] = KeyFrames(
                sizeOfScreen,
                widget.lifeAlpha,
                widget.lifeFactor,
                widget.radiusAlpha,
                widget.radiusFactor,
                widget.speedAplhaX,
                widget.speedAlphaY,
                widget.speedFactorX,
                widget.speedFactorY);
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
        painter: _DemoPainter(particleSystem, sizeOfScreen, widget.smokeFactor,
            widget.gillterFactor),
      ),
    );
  }
}

class _DemoPainter extends CustomPainter {
  final List<KeyFrames> l;
  final Size screenSize;
  final double smokeFactor;
  final double gillterFactor;
  _DemoPainter(this.l, this.screenSize, this.smokeFactor, this.gillterFactor);
  Offset ploarDistance(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var particles in l) {
      particles.display(canvas, smokeFactor, gillterFactor);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
