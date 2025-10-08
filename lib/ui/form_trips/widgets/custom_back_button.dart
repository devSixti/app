import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final Color? color;
  final TextStyle? style;
  final Color? textColor;

  const CustomBackButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = 60,
    this.color,
    this.style,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = const TextStyle(
      fontSize: AppTheme.mediumSize,
      fontWeight: FontWeight.bold,
    );

    final appliedStyle = (style ?? defaultTextStyle).copyWith(
      color: textColor ?? Colors.white,
    );

    return SizedBox(
      width: width,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color.fromRGBO(71, 70, 70, 1),
          foregroundColor: textColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: const BorderSide(color: Colors.white24),
          ),
        ),
        child: Text(
          text,
          style: appliedStyle,
        ),
      ),
    );
  }
}
