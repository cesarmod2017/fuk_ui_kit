import 'package:flutter/material.dart';

class FukTextField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final bool isRequired;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final Icon? icon;
  final VoidCallback? onIconPressed;
  final bool validate;
  final bool isPassword;
  final bool isObscure;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final FormFieldSetter<String>? onSaved;
  final TapRegionCallback? onTapOutside;

  const FukTextField({
    super.key,
    this.label,
    this.placeholder,
    this.isRequired = false,
    this.controller,
    this.decoration,
    this.icon,
    this.onIconPressed,
    this.validate = true,
    this.isPassword = false,
    this.isObscure = true,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.onTapOutside,
  });

  @override
  FukTextFieldState createState() => FukTextFieldState();
}

class FukTextFieldState extends State<FukTextField> {
  late TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword ? widget.isObscure : false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateField(String? value) {
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
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          validator: widget.validate ? _validateField : null,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          onTapOutside: widget.onTapOutside,
          onFieldSubmitted: widget.onFieldSubmitted,
          onEditingComplete: widget.keyboardType == TextInputType.multiline
              ? () {
                  widget.onFieldSubmitted?.call(_controller.text);
                }
              : widget.onEditingComplete,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          decoration: widget.decoration?.copyWith(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _toggleObscureText,
                      )
                    : widget.icon != null
                        ? IconButton(
                            icon: widget.icon!,
                            onPressed: widget.onIconPressed,
                          )
                        : null,
                hintText: widget.placeholder,
              ) ??
              InputDecoration(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _toggleObscureText,
                      )
                    : widget.icon != null
                        ? IconButton(
                            icon: widget.icon!,
                            onPressed: widget.onIconPressed,
                          )
                        : null,
                hintText: widget.placeholder,
              ),
        ),
      ],
    );
  }
}
