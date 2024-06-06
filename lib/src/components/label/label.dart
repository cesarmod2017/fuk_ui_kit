import 'package:flutter/material.dart';

enum FukLabelSize { small, medium, large }

class FukLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final FukLabelSize size;

  const FukLabel({
    super.key,
    required this.text,
    this.style,
    this.size = FukLabelSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = _getTextStyle(context);

    return Text(
      text,
      style: style ?? textStyle,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    switch (size) {
      case FukLabelSize.small:
        return Theme.of(context).textTheme.bodyMedium!;
      case FukLabelSize.large:
        return Theme.of(context).textTheme.titleLarge!;
      case FukLabelSize.medium:
      default:
        return Theme.of(context).textTheme.bodyLarge!;
    }
  }
}
