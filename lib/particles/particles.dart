import 'dart:ui';

class Particles {
  Offset position;
  Color color;
  //define velocity;
  double speed;
  double theta;
  double radius;
  List<Color> gradients;
  Particles(this.color, this.gradients, this.radius, this.position, this.speed,
      this.theta);
}
