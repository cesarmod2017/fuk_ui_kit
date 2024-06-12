import 'package:flutter/material.dart';

class TextLayer extends StatefulWidget {
  final String initialText;
  final double width;
  final double height;
  final Function onSelect;
  final bool isSelected;
  final Function onDeselect;

  const TextLayer({
    super.key,
    required this.initialText,
    required this.onSelect,
    required this.onDeselect,
    this.width = 200,
    this.height = 100,
    this.isSelected = false,
  });

  @override
  TextLayerState createState() => TextLayerState();
}

class TextLayerState extends State<TextLayer> {
  late double _x;
  late double _y;
  late double _rotation;
  late double _width;
  late double _height;
  late String _text;
  bool _isEditing = false;
  TextStyle _textStyle = const TextStyle(fontSize: 20, color: Colors.black);

  @override
  void initState() {
    super.initState();
    _x = 100;
    _y = 100;
    _rotation = 0;
    _width = widget.width;
    _height = widget.height;
    _text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _x,
      top: _y,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            _isEditing = !_isEditing;
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
          if (_isEditing) {
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
              color: Colors.transparent,
              border: Border.all(
                color: widget.isSelected ? Colors.blue : Colors.transparent,
              ),
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
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _text,
                      style: _textStyle,
                    ),
                  ),
                ),
                if (_isEditing)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        onSubmitted: (value) {
                          setState(() {
                            _text = value;
                            _isEditing = false;
                          });
                        },
                        style: _textStyle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter text',
                        ),
                      ),
                    ),
                  ),
                if (widget.isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: PopupMenuButton<TextStyle>(
                      onSelected: (style) {
                        setState(() {
                          _textStyle = style;
                        });
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: TextStyle(fontSize: 20, color: Colors.black),
                          child: Text('Default'),
                        ),
                        const PopupMenuItem(
                          value: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text('Bold'),
                        ),
                        const PopupMenuItem(
                          value: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                          child: Text('Italic'),
                        ),
                        const PopupMenuItem(
                          value: TextStyle(fontSize: 30, color: Colors.black),
                          child: Text('Large'),
                        ),
                      ],
                      icon: const Icon(Icons.text_fields),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
