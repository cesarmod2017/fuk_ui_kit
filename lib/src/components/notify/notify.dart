import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

enum FukNotifyType { info, warning, success, error, defaultType }

enum FukNotifyDirection { top, bottom }

class FukNotify {
  static void show({
    required BuildContext context,
    required String title,
    String? message,
    int duration = 3,
    FukNotifyType type = FukNotifyType.defaultType,
    FukNotifyDirection direction = FukNotifyDirection.top,
  }) {
    late OverlayEntry overlayEntry;
    Future.delayed(Duration.zero, () {
      overlayEntry = OverlayEntry(
        builder: (context) => _FukNotifyWidget(
          title: title,
          message: message,
          duration: duration,
          direction: direction,
          type: type,
          onDismiss: () {
            if (overlayEntry.mounted) {
              overlayEntry.remove();
            }
          },
        ),
      );

      Overlay.of(context).insert(overlayEntry);

      Future.delayed(Duration(seconds: duration), () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      });
    });
  }
}

class _FukNotifyWidget extends StatelessWidget {
  final String title;
  final String? message;
  final int duration;
  final FukNotifyType type;
  final FukNotifyDirection? direction;
  final VoidCallback onDismiss;

  const _FukNotifyWidget({
    required this.title,
    this.message,
    required this.duration,
    required this.type,
    required this.onDismiss,
    this.direction = FukNotifyDirection.top,
  });

  Color _getTypeColor(FukNotifyType type, BuildContext context) {
    switch (type) {
      case FukNotifyType.info:
        return Colors.blue;
      case FukNotifyType.success:
        return Colors.green;
      case FukNotifyType.warning:
        return Colors.yellow;
      case FukNotifyType.error:
        return Colors.red;
      case FukNotifyType.defaultType:
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: direction == FukNotifyDirection.top ? 50 : null,
      bottom: direction == FukNotifyDirection.bottom ? 50 : null,
      left:
          (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.1,
      right: 25,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 70,
                color: _getTypeColor(type, context),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: message == null
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                              textAlign: message == null
                                  ? TextAlign.center
                                  : TextAlign.start,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 16,
                            ),
                            color: Theme.of(context).colorScheme.onBackground,
                            onPressed: onDismiss,
                          ),
                        ],
                      ),
                      if (message != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          message!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
