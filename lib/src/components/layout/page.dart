import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FukPage extends StatelessWidget {
  final Widget? header;
  final Widget content;
  final Widget? footer;
  final Widget? aside;

  const FukPage({
    super.key,
    this.header,
    required this.content,
    this.footer,
    this.aside,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: content,
              ),
              if (aside != null)
                SizedBox(
                  width: 250.0,
                  child: aside,
                ),
            ],
          ),
        ),
        if (footer != null) footer!,
      ],
    );
  }
}
