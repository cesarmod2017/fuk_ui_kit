import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleTextFieldPage extends StatefulWidget {
  const SampleTextFieldPage({super.key});

  @override
  State<SampleTextFieldPage> createState() => _SampleTextFieldPageState();
}

class _SampleTextFieldPageState extends State<SampleTextFieldPage> {
  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Sample Text Field',
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
                const FukTextFile(
                  isRequired: true,
                  allowedFileTypes: [
                    AllowedFileType.imagePng,
                    AllowedFileType.imageJpg
                  ],
                ),
                const SizedBox(height: 20),
                const FukTextFile(
                  isRequired: true,
                  allowedFileTypes: [
                    AllowedFileType.imagePng,
                    AllowedFileType.imageJpg
                  ],
                  label: 'Select an Image',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(height: 20),
                const FukTextFile(
                  isRequired: false,
                  allowedFileTypes: [
                    AllowedFileType.documentDocx,
                    AllowedFileType.documentPdf
                  ],
                  icon: Icon(Icons.file_open),
                  label: 'Select a Document',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const FukTextFile(
                  isRequired: true,
                  allowedFileTypes: [AllowedFileType.folder],
                  icon: Icon(Icons.folder),
                  label: 'Select a Folder',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const FukTextField(
                  label: 'Name',
                  placeholder: 'Enter your name',
                  isRequired: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                FukTextField(
                  label: 'Email',
                  placeholder: 'Enter your email',
                  isRequired: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  icon: const Icon(Icons.email),
                  onIconPressed: () {
                    // Custom action for icon
                    print('Email icon pressed');
                  },
                ),
                const SizedBox(height: 20),
                FukTextField(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  isRequired: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  isPassword: true,
                  isObscure: true,
                  onIconPressed: () {
                    // Custom action for icon
                    print('Visibility icon pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      footer: const FukFooter(text: 'Footer Content Dashboard'),
    );
  }
}
