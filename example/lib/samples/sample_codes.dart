import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:fuk_ui_kit_sample/samples/examples/editor_json.dart';

class SampleCodesPage extends StatefulWidget {
  const SampleCodesPage({super.key});

  @override
  State<SampleCodesPage> createState() => _SampleCodesPageState();
}

class _SampleCodesPageState extends State<SampleCodesPage> {
  static const Map<String, Widget> _editors = {
    'Json Editor': JsonEditor(),
  };

  late int _index = 0;
  @override
  Widget build(BuildContext context) {
    final Widget child = _editors.values.elementAt(_index);
    return FukPage(
      header: FukHeader(
        title: 'Sample Codes',
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
        // backgroundColor: const Color(0xFF1E1E1E),
        child: Center(
          child: Column(
            children: [
              Row(
                children: _editors.entries.mapIndexed((index, entry) {
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        _index = index;
                      });
                    },
                    child: Text(
                      entry.key,
                      style: TextStyle(
                          color: _index == index ? null : Colors.black),
                    ),
                  );
                }).toList(),
              ),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: child,
              ))
            ],
          ),
        ),
      ),
      footer: const FukFooter(text: 'Footer Content Dashboard'),
    );
  }
}
