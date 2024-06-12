import 'package:flutter/material.dart';

class ImageOperations {
  static Widget resizeImage(Widget image, double width, double height) {
    return SizedBox(width: width, height: height, child: image);
  }

  static Widget rotateImage(Widget image, double angle) {
    return Transform.rotate(angle: angle, child: image);
  }

  // Adicionar mais operações conforme necessário
}
