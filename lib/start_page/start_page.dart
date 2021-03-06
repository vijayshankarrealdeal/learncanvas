import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncanvas/customIcon/my_ico.dart';
import 'package:learncanvas/home.dart';
import 'package:learncanvas/plaform/text.dart';
import 'package:learncanvas/smoke/smoke_control.dart';
import 'package:learncanvas/smoke/smoke_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyFunction extends Curve {
  @override
  double transformInternal(double t) {
    return exp(-t) * 7;
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;

  @override
  void initState() {
    _controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 8000));

    _controller1.repeat();
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    _controller2.repeat();
    _controller3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onClose();
        }
      });
    _controller3.forward();
    _controller4 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4650))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //  onClose();
        }
      });

    _controller4.repeat();
    // Timer(const Duration(milliseconds: 6500), onClose);
    super.initState();
  }

  void onClose() {
    Navigator.of(context).pushReplacement(
      PageTransition(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 830),
          type: PageTransitionType.fade,
          child: const MyPainter(),
          inheritTheme: false,
          ctx: context),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();

    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SmokeX>(
      builder: (context, snapshot, _) {
        return snapshot.loadImage
            ? Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/back.png'),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RotationTransition(
                          turns: CurvedAnimation(
                              parent: _controller3, curve: MyFunction()),
                          child: Icon(
                            MyFlutterApp.myIconSpeed,
                            size: 100,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: CurvedAnimation(
                            parent: _controller3, curve: Curves.decelerate),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("Puzzle+",
                                  style: PuzzleText.kPuzzlePlusLogo(context)),
                            ),
                            Text(
                              "By Team smoke",
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        fontFamily: "SFMedium",
                                        color: Colors.white,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(20, 55),
                              child: RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0)
                                    .animate(_controller1),
                                child: Icon(
                                  CupertinoIcons.settings,
                                  size: 250,
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                            ),
                            RotationTransition(
                              turns: Tween(begin: 1.0, end: 0.0)
                                  .animate(_controller2),
                              child: Icon(
                                CupertinoIcons.settings,
                                size: 100,
                                color: Colors.white.withOpacity(0.07),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(220, 80),
                              child: RotationTransition(
                                turns: Tween(begin: -2.0, end: -1.0)
                                    .animate(_controller4),
                                child: Icon(
                                  CupertinoIcons.settings,
                                  size: 400,
                                  color: Colors.white.withOpacity(0.06),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                        ),
                        child: SizedBox(
                          child: SmokeCreateWidget(
                              repeatAlways: false,
                              img: snapshot.img!,
                              angle: 1890),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
