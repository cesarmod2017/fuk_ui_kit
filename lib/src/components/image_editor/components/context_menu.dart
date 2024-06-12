import 'package:flutter/material.dart';

class ContextMenu extends StatelessWidget {
  final Offset position;
  final VoidCallback onMoveToFront;
  final VoidCallback onMoveToBack;

  const ContextMenu({
    super.key,
    required this.position,
    required this.onMoveToFront,
    required this.onMoveToBack,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'front',
            child: Text('Move to Front'),
          ),
          const PopupMenuItem(
            value: 'back',
            child: Text('Move to Back'),
          ),
        ],
        onSelected: (value) {
          if (value == 'front') {
            onMoveToFront();
          } else if (value == 'back') {
            onMoveToBack();
          }
        },
      ),
    );
  }
}
