import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FukPage extends StatelessWidget {
  final Widget header;
  final Widget content;
  final Widget footer;
  final Widget? aside;

  const FukPage({
    super.key,
    required this.header,
    required this.content,
    required this.footer,
    this.aside,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
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
        footer,
      ],
    );
  }
}
