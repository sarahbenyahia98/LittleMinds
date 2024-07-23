import 'dart:isolate';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;
import 'package:project_v1/helpers/myNavigator.dart';
import 'package:project_v1/utils/function.dart';

String type = "mobile";

// The background
SendPort? uiSendPort;
final ReceivePort port = ReceivePort();

Future<image.Image?> renderImage(assetPath, {Size? size}) async {
  var img = await loadImage(assetPath, size);

  var byteData = await img.toByteData(format: ImageByteFormat.png);
  var pngBytes = byteData!.buffer.asUint8List();
  var data = await compute(decodeImage, pngBytes);
  // var data = await Isolate.spawn(decodeImage, pngBytes);
  return data;
}

decodeImage(Uint8List pngBytes) => image.decodeImage(pngBytes);

Future<ui.Image> loadImage(imageString, Size? size) async {
  ByteData bd = await rootBundle.load(imageString);
  final Uint8List bytes = Uint8List.view(bd.buffer);
  final ui.Codec? codec;
  if (size != null) {
    codec = await instantiateImageCodec(bytes,
        targetHeight: size.height.floor(), targetWidth: size.width.floor());
  } else {
    codec = await instantiateImageCodec(bytes);
  }

  final ui.Image image = (await codec.getNextFrame()).image;

  return image;
}

cropPuzzle(img, context, Widget target) {
  IsolateNameServer.removePortNameMapping("fcmBackground");
  bool stat = IsolateNameServer.registerPortWithName(
    port.sendPort,
    "fcmBackground",
  );

  if (stat) {
    port.listen((_) async {
      StaticFunc.renderImagePuzzle(img);
      await Future.delayed(const Duration(seconds: 1)).then((value2) {
        MyNavigator.pushReplacement(context, target);
      });
    });

    SendPort? uiSendPort = IsolateNameServer.lookupPortByName("fcmBackground");
    uiSendPort?.send(true);
  }
}
    
    


