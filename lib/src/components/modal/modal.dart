import 'package:flutter/material.dart';

enum FukModalSize { small, medium, large, fullscreen }

class FukModal extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> leftActions;
  final List<Widget> rightActions;
  final Color? headerColor;
  final Color? contentColor;
  final Color? footerColor;
  final FukModalSize size;

  const FukModal({
    super.key,
    required this.title,
    required this.content,
    this.leftActions = const [],
    this.rightActions = const [],
    this.headerColor,
    this.contentColor,
    this.footerColor,
    this.size = FukModalSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: _getConstraints(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            _buildContent(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  BoxConstraints _getConstraints(BuildContext context) {
    double width;
    double height;

    switch (size) {
      case FukModalSize.small:
        width = MediaQuery.of(context).size.width * 0.3;
        height = MediaQuery.of(context).size.height * 0.3;
        break;
      case FukModalSize.large:
        width = MediaQuery.of(context).size.width * 0.8;
        height = MediaQuery.of(context).size.height * 0.8;
        break;
      case FukModalSize.fullscreen:
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
        break;
      case FukModalSize.medium:
      default:
        width = MediaQuery.of(context).size.width * 0.5;
        height = MediaQuery.of(context).size.height * 0.5;
        break;
    }

    return BoxConstraints(
      maxWidth: width,
      maxHeight: height,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: headerColor ?? Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: contentColor ?? Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: footerColor ?? Theme.of(context).colorScheme.secondaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: leftActions),
          Row(children: rightActions),
        ],
      ),
    );
  }
}
