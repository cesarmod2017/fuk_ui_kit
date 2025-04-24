import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum AllowedFileType {
  all,
  imagePng,
  imageJpg,
  imageJpeg,
  documentPdf,
  documentDoc,
  documentDocx,
  documentXls,
  documentXlsx,
  folder,
}

class FukTextFile extends StatefulWidget {
  final bool isRequired;
  final List<AllowedFileType> allowedFileTypes;
  final TextEditingController? controller;
  final Icon? icon;
  final bool validate;
  final String? label;
  final InputDecoration? decoration;
  final String? hintText;

  const FukTextFile({
    super.key,
    this.isRequired = false,
    this.allowedFileTypes = const [AllowedFileType.all],
    this.controller,
    this.icon,
    this.validate = true,
    this.label,
    this.decoration,
    this.hintText,
  });

  @override
  FukTextFileState createState() => FukTextFileState();
}

class FukTextFileState extends State<FukTextFile> {
  late TextEditingController _controller;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  Future<void> _pickFile() async {
    FileType fileType = _mapAllowedFileType(widget.allowedFileTypes);

    if (widget.allowedFileTypes.contains(AllowedFileType.folder)) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        setState(() {
          _filePath = selectedDirectory;
          _controller.text = _filePath!;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: _getAllowedExtensions(widget.allowedFileTypes),
      );

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
          _controller.text = _filePath!;
        });
      }
    }
  }

  FileType _mapAllowedFileType(List<AllowedFileType> types) {
    if (types.contains(AllowedFileType.folder)) {
      return FileType.any; // Handle folder separately
    } else if (types.length == 1) {
      switch (types.first) {
        case AllowedFileType.all:
          return FileType.any;
        case AllowedFileType.imagePng:
        case AllowedFileType.imageJpg:
        case AllowedFileType.imageJpeg:
          return FileType.image;
        case AllowedFileType.documentPdf:
        case AllowedFileType.documentDoc:
        case AllowedFileType.documentDocx:
        case AllowedFileType.documentXls:
        case AllowedFileType.documentXlsx:
          return FileType.custom;
        default:
          return FileType.any;
      }
    } else {
      return FileType.custom;
    }
  }

  List<String>? _getAllowedExtensions(List<AllowedFileType> types) {
    if (types.contains(AllowedFileType.folder)) {
      return null; // No extensions needed for folder selection
    } else if (types.isNotEmpty) {
      return types
          .map((type) {
            switch (type) {
              case AllowedFileType.imagePng:
                return 'png';
              case AllowedFileType.imageJpg:
                return 'jpg';
              case AllowedFileType.imageJpeg:
                return 'jpeg';
              case AllowedFileType.documentPdf:
                return 'pdf';
              case AllowedFileType.documentDoc:
                return 'doc';
              case AllowedFileType.documentDocx:
                return 'docx';
              case AllowedFileType.documentXls:
                return 'xls';
              case AllowedFileType.documentXlsx:
                return 'xlsx';
              default:
                return null;
            }
          })
          .where((ext) => ext != null)
          .cast<String>()
          .toList();
    }
    return null;
  }

  String? _validateFile(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: _controller,
          validator: widget.validate ? _validateFile : null,
          decoration: widget.decoration?.copyWith(
                suffixIcon: IconButton(
                  icon: widget.icon ?? const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                hintText: widget.hintText ?? 'Select a file',
              ) ??
              InputDecoration(
                suffixIcon: IconButton(
                  icon: widget.icon ?? const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                hintText: widget.hintText ?? 'Select a file',
              ),
        ),
      ],
    );
  }
}
