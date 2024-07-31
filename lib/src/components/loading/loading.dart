import 'package:flutter/material.dart';

enum FukLoadingAlignment {
  centerTop,
  centerBottom,
  center,
  bottomRight,
  topRight
}

class FukLoading {
  OverlayEntry? _currentOverlay;

  void show({
    required BuildContext context,
    FukLoadingAlignment alignment = FukLoadingAlignment.center,
    bool blockScreen = true,
    String? title,
    bool showDelayMessage = false,
    int delayDuration = 5,
    String delayMessage =
        "This is taking longer than expected. Do you want to cancel?",
    String continueButtonText = "Continue",
    String cancelButtonText = "Cancel",
    VoidCallback? onCancel,
  }) {
    _currentOverlay = OverlayEntry(
      builder: (context) => _FukLoadingWidget(
        alignment: alignment,
        blockScreen: blockScreen,
        title: title,
        showDelayMessage: showDelayMessage,
        delayDuration: delayDuration,
        delayMessage: delayMessage,
        continueButtonText: continueButtonText,
        cancelButtonText: cancelButtonText,
        onCancel: onCancel,
        overlayEntry: _currentOverlay!,
      ),
    );

    Overlay.of(context).insert(_currentOverlay!);
  }

  void hide() {
    if (_currentOverlay != null) {
      _currentOverlay?.remove();
      _currentOverlay = null;
    }
  }
}

class _FukLoadingWidget extends StatefulWidget {
  final FukLoadingAlignment alignment;
  final bool blockScreen;
  final String? title;
  final bool showDelayMessage;
  final int delayDuration;
  final String delayMessage;
  final String continueButtonText;
  final String cancelButtonText;
  final VoidCallback? onCancel;
  final OverlayEntry overlayEntry;

  const _FukLoadingWidget({
    required this.alignment,
    required this.blockScreen,
    this.title,
    required this.showDelayMessage,
    required this.delayDuration,
    required this.delayMessage,
    required this.continueButtonText,
    required this.cancelButtonText,
    this.onCancel,
    required this.overlayEntry,
  });

  @override
  State<_FukLoadingWidget> createState() => __FukLoadingWidgetState();
}

class __FukLoadingWidgetState extends State<_FukLoadingWidget> {
  bool _showDelayMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.showDelayMessage) {
      Future.delayed(Duration(seconds: widget.delayDuration), () {
        if (mounted) {
          setState(() {
            _showDelayMessage = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.blockScreen)
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacity(0.5),
          ),
        Align(
          alignment: _getAlignment(),
          child: Material(
            color: Colors.transparent,
            child: _showDelayMessage ? _buildDelayMessage() : _buildLoading(),
          ),
        ),
      ],
    );
  }

  Alignment _getAlignment() {
    switch (widget.alignment) {
      case FukLoadingAlignment.centerTop:
        return Alignment.topCenter;
      case FukLoadingAlignment.centerBottom:
        return Alignment.bottomCenter;
      case FukLoadingAlignment.bottomRight:
        return Alignment.bottomRight;
      case FukLoadingAlignment.topRight:
        return Alignment.topRight;
      case FukLoadingAlignment.center:
      default:
        return Alignment.center;
    }
  }

  Widget _buildLoading() {
    return Padding(
      padding: (widget.alignment == FukLoadingAlignment.bottomRight ||
              widget.alignment == FukLoadingAlignment.topRight)
          ? const EdgeInsets.all(24.0)
          : const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: (widget.alignment == FukLoadingAlignment.center ||
                widget.alignment == FukLoadingAlignment.centerBottom ||
                widget.alignment == FukLoadingAlignment.centerTop)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                  if (widget.title != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                  if (widget.title != null) ...[
                    const SizedBox(width: 10),
                    Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _buildDelayMessage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.delayMessage,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _showDelayMessage = false;
                  });
                },
                child: Text(widget.continueButtonText),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  widget.onCancel?.call();
                  if (widget.overlayEntry.mounted) {
                    widget.overlayEntry.remove();
                  }
                },
                child: Text(widget.cancelButtonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
