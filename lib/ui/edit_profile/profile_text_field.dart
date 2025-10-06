import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final String? hintText;
  final bool enabled;
  final IconData? icon;
  final int? maxLength;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.hintText,
    this.enabled = true,
    this.icon,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      maxLength: maxLength,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        suffixIcon: icon != null ? Icon(icon, color: Colors.grey[400]) : null,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7C4DFF)),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        counterText: maxLength != null ? null : '',
      ),
      cursorColor: const Color(0xFF7C4DFF),
    );
  }
}
