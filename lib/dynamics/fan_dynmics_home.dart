import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learncanvas/customIcon/my_ico.dart';

class FanDynamics extends StatefulWidget {
  const FanDynamics({Key? key}) : super(key: key);

  @override
  _FanDynamicsState createState() => _FanDynamicsState();
}

class _FanDynamicsState extends State<FanDynamics>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.forward();
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 2*pi, end: 0).animate(_controller),
      child: Icon(
        MyFlutterApp.myIconSpeed,
        size: 200,
        color: Colors.white.withOpacity(0.15),
      ),
    );
  }
}
