import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      maxLength: 20,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.lightGreyContainer),
        filled: true,
        fillColor: AppTheme.inputBackgroundDark,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: AppTheme.border,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppTheme.border,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppTheme.border,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
