import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleButtonPage extends StatefulWidget {
  const SampleButtonPage({super.key});

  @override
  State<SampleButtonPage> createState() => _SampleButtonPageState();
}

class _SampleButtonPageState extends State<SampleButtonPage> {
  bool _isLoading = false;

  void _simulateLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Sample Buttons',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FukLabel(
                text: 'Basic Button:',
                size: FukLabelSize.small,
              ),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(
                text: 'Button with Icon (Left):',
                size: FukLabelSize.large,
              ),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(
                  Icons.send,
                  size: 16,
                ),
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Button with Icon (Right):'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(Icons.send),
                iconOnRight: true,
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Button with Icon (Below Text):'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(Icons.send),
                iconBelowText: true,
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Icon Only Button:'),
              const SizedBox(height: 8),
              FukButton(
                icon: const Icon(Icons.send),
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(
                  text: 'Button with Custom Colors and Rounded Border:'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(Icons.send),
                onPressed: _simulateLoading,
                isLoading: _isLoading,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                borderRadius: 16.0,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Full Width Button:'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                onPressed: _simulateLoading,
                isLoading: _isLoading,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
    );
  }
}
