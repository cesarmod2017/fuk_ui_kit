import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleNotifyPage extends StatefulWidget {
  const SampleNotifyPage({super.key});

  @override
  State<SampleNotifyPage> createState() => _SampleNotifyPageState();
}

class _SampleNotifyPageState extends State<SampleNotifyPage> {
  int _counter = 0;
  void _showLoading(BuildContext context) {
    final loading = FukLoading();
    loading.show(
      context: context,
      alignment: _counter == 0
          ? FukLoadingAlignment.bottomRight
          : FukLoadingAlignment.topRight,
      blockScreen: false,
      title: 'Loading...',
      showDelayMessage: true,
      delayDuration: 60,
      delayMessage:
          'This is taking longer than expected. Do you want to cancel?',
      continueButtonText: 'Continue',
      cancelButtonText: 'Fechar',
      onCancel: () {
        loading.hide();
      },
    );

    // Simulate a network request or long running task
    Future.delayed(const Duration(seconds: 10), () {
      loading.hide();
    });

    _counter = _counter + 1;
    if (_counter > 1) _counter = 0;
  }

  void _showNotification(
      BuildContext context, FukNotifyType type, FukNotifyDirection direction) {
    FukNotify.show(
      context: context,
      title: 'Notification Title',
      message: 'This is the detail message for the notification.',
      type: type,
      direction: direction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Notify Samples',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: Center(
          child: Column(
            children: [
              FukButton(
                text: 'Show Info Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.info, FukNotifyDirection.top),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Success Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.success, FukNotifyDirection.bottom),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Warning Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.warning, FukNotifyDirection.top),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Error Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.error, FukNotifyDirection.top),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Default Notification',
                onPressed: () => _showNotification(context,
                    FukNotifyType.defaultType, FukNotifyDirection.bottom),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Loading',
                onPressed: () => _showLoading(context),
              )
            ],
          ),
        ),
      ),
      footer: const FukFooter(text: 'Footer Content'),
      aside: Container(
        color: Colors.grey[800],
        child: const Center(
          child: Text('Aside Content'),
        ),
      ),
    );
  }
}
