import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PuzzlePlatform {
  static double kheightBoard(BuildContext context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.height * 0.74;
    }
    if (Platform.isAndroid) {
      return MediaQuery.of(context).size.height * 0.45;
    }
    return MediaQuery.of(context).size.height * 0.57;
  }

  static double kwidthBoard(BuildContext context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.width * 0.5;
    }
    if (Platform.isAndroid) {
      return MediaQuery.of(context).size.height * 0.4;
    }
    return MediaQuery.of(context).size.width * 0.4;
  }

  static double kaspectRationBoard(BuildContext context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.aspectRatio * 0.75;
    }
    if (Platform.isAndroid) {
      return 1;
    }
    return MediaQuery.of(context).size.aspectRatio * 0.75;
  }

  static double kwidthButton(BuildContext context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.width * 0.5;
    }
    if (Platform.isAndroid) {
      return MediaQuery.of(context).size.height * 0.27;
    }
    return MediaQuery.of(context).size.width * 0.3;
  }
}
