import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
import 'package:project_v1/helpers/myNavigator.dart';
import 'package:project_v1/utils/function.dart';

String type = "web";

Future<image.Image?> renderImage(String assetPath, {Size? size}) async {
  html.ImageElement myImageElement = html.ImageElement(src: "assets/" + assetPath);

  size ??= Size(myImageElement.width!.toDouble(), myImageElement.height!.toDouble());

  await myImageElement.onLoad.first;

  // Allow time for the browser to render
  html.CanvasElement myCanvas = html.CanvasElement(
    width: myImageElement.width,
    height: myImageElement.height,
  );
  html.CanvasRenderingContext2D ctx = myCanvas.context2D;

  ctx.drawImageScaled(
    myImageElement,
    0,
    0,
    size.width.floor(),
    size.height.floor(),
  );

  html.ImageData rgbaData = ctx.getImageData(
    0,
    0,
    size.width.floor(),
    size.height.floor(),
  );

  var myImage = image.Image.fromBytes(
    width: rgbaData.width,
    height: rgbaData.height,
    bytes: Uint8List.fromList(rgbaData.data).buffer,
   // 
   // 
    //
  );

  return myImage;
}

Future<void> cropPuzzle(img, context, Widget target) async {
  await compute(renderImageCompute, img);

  // Add a delay after the image processing is complete
  await Future.delayed(const Duration(seconds: 1));

  // Use pushReplacement to navigate to the target screen
  MyNavigator.pushReplacement(context, target);
}

void renderImageCompute(img) {
  StaticFunc.renderImagePuzzle(img);
}
