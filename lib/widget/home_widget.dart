import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learncanvas/particles/particle_widget.dart';
import 'package:learncanvas/smoke/smoke_control.dart';
import 'package:learncanvas/smoke/smoke_widget.dart';
import 'package:provider/provider.dart';

class SmokeWidgetHome extends StatelessWidget {
  const SmokeWidgetHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmokeX>(builder: (context, snapshot, _) {
      return snapshot.loadImage
          ? SizedBox(
              child: Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width * 0.5,
                    MediaQuery.of(context).size.height * 0.6),
                child: SmokeCreateWidget(
                    repeatAlways: false, angle: -5, img: snapshot.img!),
              ),
            )
          : const SizedBox();
    });
  }
}

class ParticleWidgetHome extends StatelessWidget {
  const ParticleWidgetHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: const ParticleWidget());
  }
}

class NumDial extends StatelessWidget {
  const NumDial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Platform.isAndroid
            ? MediaQuery.of(context).size.height * 0.45
            : MediaQuery.of(context).size.height * 0.54,
        width: Platform.isAndroid
            ? MediaQuery.of(context).size.height * 0.4
            : MediaQuery.of(context).size.width * 0.4,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: Platform.isAndroid
                ? 1
                : MediaQuery.of(context).size.aspectRatio * 0.75,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (ctx, index) {
            return (index + 1) == 16
                ? const SizedBox()
                : ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white.withOpacity(0.04),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: Platform.isAndroid
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.85),
                                    )
                                : Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.85),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
          itemCount: 16,
        ),
      ),
    );
  }
}
