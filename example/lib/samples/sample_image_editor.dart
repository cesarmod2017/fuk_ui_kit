import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleImageEditorPage extends StatefulWidget {
  const SampleImageEditorPage({super.key});

  @override
  State<SampleImageEditorPage> createState() => _SampleImageEditorPageState();
}

class _SampleImageEditorPageState extends State<SampleImageEditorPage> {
  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Image Editor Sample',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      content: const FukContent(
        child: FukImageEditor(),
      ),
      footer: const FukFooter(text: 'Footer Content'),
      // aside: Container(
      //   color: Colors.grey[800],
      //   child: const Center(
      //     child: Text('Aside Content'),
      //   ),
      // ),
    );
  }
}
