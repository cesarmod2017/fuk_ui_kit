import 'package:flutter/material.dart';

class FukAside extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const FukAside({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(-2, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
