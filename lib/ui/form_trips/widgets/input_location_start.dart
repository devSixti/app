import 'package:flutter/material.dart';

class InputsLocation extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const InputsLocation({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.hintText,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: iconColor),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
