import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fuk_ui_kit/src/components/image_editor/components/image_layer.dart';

import '../utils/file_picker.dart';
import 'canvas_area.dart';
import 'shape_layer.dart';
import 'text_layer.dart';

class Toolbar extends StatelessWidget {
  final GlobalKey<CanvasAreaState> canvasKey;

  const Toolbar({super.key, required this.canvasKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.create_new_folder),
            onPressed: () {
              canvasKey.currentState?.clearLayers();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () async {
              final file = await pickFile();
              if (file != null) {
                canvasKey.currentState?.addLayer(
                  ImageLayer(imagePath: file),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.crop),
            onPressed: () {
              // Cortar imagem
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter),
            onPressed: () {
              // Adicionar efeitos
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Salvar imagem
            },
          ),
          PopupMenuButton<ShapeType>(
            onSelected: (shape) {
              _showColorPicker(context).then((color) {
                if (color != null) {
                  canvasKey.currentState?.addLayer(
                    ShapeLayer(
                      shapeType: shape,
                      color: color,
                      onSelect: () {},
                      onDeselect: () {},
                    ),
                  );
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ShapeType.rectangle,
                child: Text('Add Rectangle'),
              ),
              const PopupMenuItem(
                value: ShapeType.circle,
                child: Text('Add Circle'),
              ),
              const PopupMenuItem(
                value: ShapeType.line,
                child: Text('Add Line'),
              ),
            ],
            icon: const Icon(Icons.add_box),
          ),
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () {
              canvasKey.currentState?.addLayer(
                TextLayer(
                  initialText: 'Your Text Here',
                  onSelect: () {},
                  onDeselect: () {},
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (size) {
              switch (size) {
                case '500x500':
                  canvasKey.currentState?.setCanvasSize(500, 500);
                  break;
                case '800x800':
                  canvasKey.currentState?.setCanvasSize(800, 800);
                  break;
                case '1080x1024':
                  canvasKey.currentState?.setCanvasSize(1080, 1024);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: '500x500',
                child: Text('500x500'),
              ),
              const PopupMenuItem(
                value: '800x800',
                child: Text('800x800'),
              ),
              const PopupMenuItem(
                value: '1080x1024',
                child: Text('1080x1024'),
              ),
            ],
            icon: const Icon(Icons.aspect_ratio),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              canvasKey.currentState?.zoomIn();
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              canvasKey.currentState?.zoomOut();
            },
          ),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              _showColorPicker(context).then((color) {
                if (color != null) {
                  canvasKey.currentState?.updateSelectedLayersColor(color);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Future<Color?> _showColorPicker(BuildContext context) async {
    Color selectedColor = Colors.blue;
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
