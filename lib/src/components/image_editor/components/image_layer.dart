import 'package:flutter/material.dart';

class ImageLayer extends StatelessWidget {
  final String imagePath;
  const ImageLayer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100,
      top: 100,
      child: Draggable(
        feedback: Image.asset(imagePath),
        child: Image.asset(imagePath),
        onDragEnd: (details) {
          // Atualizar a posição da imagem
        },
      ),
    );
  }
}
