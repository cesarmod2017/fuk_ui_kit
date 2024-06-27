import 'package:flutter/material.dart';

class FukContent extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FukContent({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: child,
    );
  }
}
