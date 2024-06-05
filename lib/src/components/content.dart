import 'package:flutter/material.dart';

class FukContent extends StatelessWidget {
  final Widget child;

  const FukContent({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: child,
    );
  }
}
