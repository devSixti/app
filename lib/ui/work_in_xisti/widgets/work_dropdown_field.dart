// Widget reutilizable para Dropdown con estilo consistente del módulo "Trabaja en Xisti".

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class WorkDropdownField extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const WorkDropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final String? safeValue = (value != null && items.contains(value)) ? value : null;

    return DropdownButtonFormField<String>(
      value: safeValue,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.greyTextColor),
        filled: true,
        fillColor: AppTheme.darkGreyContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppTheme.greyTextColor),
      dropdownColor: AppTheme.darkGreyContainer,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(color: AppTheme.whiteContainer)),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
