import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/src/components/image_editor/components/canvas_area.dart';
import 'package:fuk_ui_kit/src/components/image_editor/components/toolbar.dart';

class FukImageEditor extends StatefulWidget {
  const FukImageEditor({super.key});

  @override
  FukImageEditorState createState() => FukImageEditorState();
}

class FukImageEditorState extends State<FukImageEditor> {
  final GlobalKey<CanvasAreaState> _canvasKey = GlobalKey<CanvasAreaState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Toolbar(canvasKey: _canvasKey),
        Expanded(
          child: CanvasArea(key: _canvasKey),
        ),
      ],
    );
  }
}
