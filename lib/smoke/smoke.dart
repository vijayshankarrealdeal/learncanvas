import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:learncanvas/smoke/square.dart';

Offset ploarDistance(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyBoxPainter extends CustomPainter {
  List<Square> sq;
  Random rgn;
  double animation;
  ui.Image img;
  double angle;
  MyBoxPainter(
      {required this.sq,
      required this.angle,
      required this.img,
      required this.animation,
      required this.rgn});
  @override
  void paint(Canvas canvas, Size size) {
    for (var s in sq) {
      int dy = sq.indexOf(s);
      double dx = animation;
     angle != 0? canvas.rotate(angle):null;
      paintImage(
          fit: BoxFit.fill,
          opacity: -dx.toDouble(),
          canvas: canvas,
          rect:
              Offset(dx * s.position.dx * 9, dy * 4 * s.speed * sin(s.theta)) &
                  Size(s.side, s.side),
          image: img);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
