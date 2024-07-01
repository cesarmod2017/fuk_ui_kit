import 'package:flutter/material.dart';

class FukDropdown<T> extends StatelessWidget {
  final String? placeholder;
  final String? label;
  final List<T> data;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String Function(T)? displayItem;
  final InputDecoration? decoration;
  final bool isExpanded;

  const FukDropdown({
    super.key,
    this.placeholder,
    this.label,
    required this.data,
    this.selectedItem,
    required this.onChanged,
    this.displayItem,
    this.decoration,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          decoration: decoration?.copyWith(
                hintText: placeholder,
              ) ??
              InputDecoration(
                hintText: placeholder,
              ),
          value: selectedItem,
          isExpanded: isExpanded,
          items: data.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                  displayItem != null ? displayItem!(value) : value.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
