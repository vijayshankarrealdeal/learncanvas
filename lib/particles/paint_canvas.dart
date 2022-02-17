import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:learncanvas/particles/particles.dart';

Offset ploarDistance(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyCustomCanvas extends CustomPainter {
  List<Particles> particles;
  Random rgn;
  double animationValue;
  MyCustomCanvas(
      {required this.particles,
      required this.animationValue,
      required this.rgn});
  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      var velocity = ploarDistance(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;
      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    }

    for (var p in particles) {
      var paint = Paint()
        ..shader = ui.Gradient.radial(p.position, p.radius, p.gradients);
      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
    
 