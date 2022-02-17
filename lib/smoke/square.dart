import 'package:flutter/cupertino.dart';

class Square {
  Offset position;
  double side;
  double speed;
  double theta;
  Square(
      {required this.side,
      required this.speed,
      required this.theta,
      required this.position});
}
