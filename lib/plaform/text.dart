import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PuzzleText {
  static TextStyle kPuzzlePlusLogo(BuildContext context) {
    if (kIsWeb) {
      return Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 28,
            fontFamily: "SFMedium",
            color: Colors.white,
          );
    }
    if (Platform.isAndroid) {
      return Theme.of(context).textTheme.headline2!.copyWith(
            fontFamily: "SFMedium",
            color: Colors.white,
          );
    }
    return Theme.of(context).textTheme.displayLarge!.copyWith(
          fontFamily: "SFMedium",
          color: Colors.white,
        );
  }

  static TextStyle kHeadingText(BuildContext context) {
    if (kIsWeb) {
      return Theme.of(context).textTheme.bodyText1!.copyWith(
            fontFamily: 'SFMedium',
            color: Colors.white,
          );
    }
    if (Platform.isAndroid) {
      return Theme.of(context).textTheme.bodyText1!.copyWith(
            fontFamily: 'SFMedium',
            color: Colors.white,
          );
    }
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontFamily: 'SFMedium',
          color: Colors.white,
        );
  }

  static TextStyle kTimerDigits(BuildContext context) {
    if (kIsWeb) {
      return Theme.of(context).textTheme.bodyText2!.copyWith(
            fontFamily: 'SFMedium',
            color: Colors.white,
          );
    }
    if (Platform.isAndroid) {
      return Theme.of(context).textTheme.bodyText2!.copyWith(
            fontFamily: 'SFMedium',
            color: Colors.white,
          );
    }
    return Theme.of(context).textTheme.bodyText2!.copyWith(
          fontFamily: 'SFMedium',
          color: Colors.white,
        );
  }

  static TextStyle kBoardNumber(BuildContext context) {
    if (kIsWeb) {
      return Theme.of(context).textTheme.displaySmall!.copyWith(
            fontFamily: 'SFMedium',
            fontSize: MediaQuery.of(context).size.height * 0.06,
            fontWeight: FontWeight.w700,
            color: Colors.white.withOpacity(0.85),
          );
    }
    if (Platform.isAndroid) {
      return Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontFamily: 'SFMedium',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white.withOpacity(0.85),
          );
    }
    return Theme.of(context).textTheme.displaySmall!.copyWith(
          fontFamily: 'SFMedium',
          fontSize: MediaQuery.of(context).size.height * 0.06,
          fontWeight: FontWeight.w700,
          color: Colors.white.withOpacity(0.85),
        );
  }
}
