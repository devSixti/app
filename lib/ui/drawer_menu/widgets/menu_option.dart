// Archivo de menú completo

import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color.fromRGBO(255, 255, 255, 1),
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 2,
      ),
    );
  }
}
