import 'package:flutter/material.dart';

class FukContent extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  const FukContent({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: child,
    );
  }
}
