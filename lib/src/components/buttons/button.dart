import 'package:flutter/material.dart';

class FukButton extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final bool iconOnRight;
  final bool iconBelowText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final bool fullWidth;

  const FukButton({
    super.key,
    this.text,
    this.icon,
    this.iconOnRight = false,
    this.iconBelowText = false,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor:
              textColor ?? Theme.of(context).primaryTextTheme.labelLarge?.color,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (icon != null && text != null) {
      if (iconBelowText) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            const SizedBox(height: 4),
            Text(text!),
          ],
        );
      } else if (iconOnRight) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text!),
            const SizedBox(width: 8),
            icon!,
          ],
        );
      } else {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            const SizedBox(width: 8),
            Text(text!),
          ],
        );
      }
    } else if (icon != null) {
      return icon!;
    } else {
      return Text(text!);
    }
  }
}
