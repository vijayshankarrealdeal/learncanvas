import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class SmokeX extends ChangeNotifier {
  SmokeX() {
    get();
  }
  ui.Image? img;
  bool loadImage = false;

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<void> get() async {
    try {
      img = await load('assets/images/5.png');
      loadImage = true;
      notifyListeners();
    } catch (e) {
      rethrow ;
    }
  }
}
