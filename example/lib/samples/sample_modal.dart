import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleModalPage extends StatefulWidget {
  const SampleModalPage({super.key});

  @override
  State<SampleModalPage> createState() => _SampleModalPageState();
}

class _SampleModalPageState extends State<SampleModalPage> {
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FukModal(
          title: 'Modal Title',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              100,
              (index) => Text('Item ${index.toString()}'),
            ),
          ),
          // size: FukModalSize.fullscreen,
          leftActions: [
            FukButton(
              text: 'Custom Action',
              onPressed: () {
                // Handle custom action
              },
            ),
          ],
          rightActions: [
            FukButton(
              text: 'Submit',
              onPressed: () {
                // Handle submit action
              },
            ),
            const SizedBox(width: 10),
            FukButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Sample Modal',
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const FukLabel(
                  text: 'Modal:',
                  size: FukLabelSize.small,
                ),
                FukButton(
                  text: 'Show Modal',
                  onPressed: () => _showModal(context),
                ),
              ],
            ),
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
    );
  }
}
