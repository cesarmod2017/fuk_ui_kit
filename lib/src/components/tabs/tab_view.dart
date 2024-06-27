import 'package:flutter/material.dart';

class FukTabView extends StatelessWidget {
  final String? title;
  final Widget? child;
  final ValueSetter<int>? onClose;
  final VoidCallback? onNewTab;
  final int index;

  const FukTabView({
    super.key,
    required this.index,
    this.title,
    this.child,
    this.onClose,
    this.onNewTab,
  });

  Tab get tab => Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? Flexible(
                    child: Text(title!,
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                  )
                : const SizedBox.shrink(),
            IconButton(
              icon: Icon(
                onClose != null ? Icons.close : Icons.add,
                size: onClose != null ? 12 : 18,
                color: onClose != null ? Colors.red : Colors.blue,
              ),
              onPressed: () {
                if (onClose != null) {
                  onClose!(index);
                } else {
                  onNewTab!();
                }
              },
            ),
          ],
        ),
      );

  Widget get view => child ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
