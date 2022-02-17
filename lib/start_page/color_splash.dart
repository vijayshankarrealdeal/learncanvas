import 'package:flutter/material.dart';

class Burst extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;

    var dx = 20.0;
    var dy = 20.0;
    canvas.drawCircle(Offset(dx, dy), 20.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
