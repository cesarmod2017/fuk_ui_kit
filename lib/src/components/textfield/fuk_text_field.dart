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
          validator: widget.validate ? _validateField : null,
          obscureText: _obscureText,
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
