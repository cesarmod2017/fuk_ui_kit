import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ShapeLayer extends StatefulWidget {
  final ShapeType shapeType;
  final Color color;
  final double width;
  final double height;
  final Function onSelect;
  final bool isSelected;
  final Function onDeselect;

  const ShapeLayer({
    super.key,
    required this.shapeType,
    required this.color,
    required this.onSelect,
    required this.onDeselect,
    this.width = 100,
    this.height = 100,
    this.isSelected = false,
  });

  @override
  ShapeLayerState createState() => ShapeLayerState();
}

class ShapeLayerState extends State<ShapeLayer> {
  late double _x;
  late double _y;
  late double _rotation;
  late double _width;
  late double _height;
  late Color _color;
  bool _isResizing = false;

  @override
  void initState() {
    super.initState();
    _x = 100;
    _y = 100;
    _rotation = 0;
    _width = widget.width;
    _height = widget.height;
    _color = widget.color;
  }

  void updateColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _x,
      top: _y,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            _isResizing = !_isResizing;
          });
        },
        onTap: () {
          if (widget.isSelected) {
            widget.onDeselect();
          } else {
            widget.onSelect();
          }
        },
        onPanUpdate: (details) {
          if (_isResizing) {
            setState(() {
              _width += details.delta.dx;
              _height += details.delta.dy;
            });
          } else {
            setState(() {
              _x += details.delta.dx;
              _y += details.delta.dy;
            });
          }
        },
        child: Transform.rotate(
          angle: _rotation,
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color.withOpacity(0.7),
              shape: widget.shapeType == ShapeType.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              border: widget.isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : null,
            ),
            child: Stack(
              children: [
                if (widget.isSelected) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width -= details.delta.dx;
                          _height -= details.delta.dy;
                          _x += details.delta.dx;
                          _y += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width += details.delta.dx;
                          _height -= details.delta.dy;
                          _y += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width -= details.delta.dx;
                          _height += details.delta.dy;
                          _x += details.delta.dx;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width += details.delta.dx;
                          _height += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showColorPicker(context).then((color) {
                          if (color != null) {
                            setState(() {
                              _color = color;
                            });
                          }
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: const Icon(Icons.color_lens, size: 16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _rotation += details.delta.dx * 0.01;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: const Icon(Icons.rotate_right, size: 16),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Color?> _showColorPicker(BuildContext context) async {
    Color selectedColor = _color;
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
            ),
          ],
        );
      },
    );
  }
}

enum ShapeType { rectangle, circle, line }
