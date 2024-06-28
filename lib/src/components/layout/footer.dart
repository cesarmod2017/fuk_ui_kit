import 'package:flutter/material.dart';

class FukFooter extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? width;
  const FukFooter({
    super.key,
    required this.child,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: child,
    );
  }
}
