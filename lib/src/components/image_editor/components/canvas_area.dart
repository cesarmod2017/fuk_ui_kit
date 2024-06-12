import 'package:flutter/material.dart';

import 'shape_layer.dart';

class CanvasArea extends StatefulWidget {
  const CanvasArea({super.key});

  @override
  CanvasAreaState createState() => CanvasAreaState();
}

class CanvasAreaState extends State<CanvasArea> {
  List<Widget> layers = [];
  double _canvasWidth = 500;
  double _canvasHeight = 500;
  double _scale = 1.0;
  Set<int> selectedIndices = {};

  void addLayer(Widget layer) {
    setState(() {
      layers.add(layer);
    });
  }

  void clearLayers() {
    setState(() {
      layers.clear();
      selectedIndices.clear();
    });
  }

  void setCanvasSize(double width, double height) {
    setState(() {
      _canvasWidth = width;
      _canvasHeight = height;
    });
  }

  void zoomIn() {
    setState(() {
      _scale += 0.1;
    });
  }

  void zoomOut() {
    setState(() {
      _scale = (_scale - 0.1).clamp(0.1, 10.0);
    });
  }

  void selectLayer(int index) {
    setState(() {
      selectedIndices.add(index);
    });
  }

  void deselectLayer(int index) {
    setState(() {
      selectedIndices.remove(index);
    });
  }

  void deselectAllLayers() {
    setState(() {
      selectedIndices.clear();
    });
  }

  void updateSelectedLayersColor(Color color) {
    for (int index in selectedIndices) {
      if (layers[index] is ShapeLayer) {
        (layers[index] as ShapeLayerState).updateColor(color);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: Transform.scale(
          scale: _scale,
          child: Container(
            width: _canvasWidth,
            height: _canvasHeight,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                deselectAllLayers();
              },
              child: Stack(
                children: List.generate(layers.length, (index) {
                  return layers[index] is ShapeLayer
                      ? ShapeLayer(
                          shapeType: (layers[index] as ShapeLayer).shapeType,
                          color: (layers[index] as ShapeLayer).color,
                          onSelect: () => selectLayer(index),
                          onDeselect: () => deselectLayer(index),
                          isSelected: selectedIndices.contains(index),
                        )
                      : layers[index];
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
