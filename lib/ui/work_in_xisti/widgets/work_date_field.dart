// Widget reutilizable para campo de fecha con DatePicker y estilo consistente.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_theme.dart';

class WorkDateField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Locale locale;

  const WorkDateField({
    super.key,
    required this.hint,
    required this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.locale = const Locale('es', 'ES'),
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime first = firstDate ?? DateTime(1900);
    final DateTime last = lastDate ?? now;

    // Selecciona una fecha inicial segura dentro del rango [first, last].
    DateTime safeInit = initialDate ?? now;
    if (safeInit.isBefore(first)) safeInit = first;
    if (safeInit.isAfter(last)) safeInit = last;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: safeInit,
      firstDate: first,
      lastDate: last,
      locale: locale,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppTheme.primaryColor,
              onSurface: AppTheme.whiteContainer,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy', 'es_ES').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _pickDate(context),
      style: TextStyle(color: AppTheme.whiteContainer),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.greyTextColor),
        filled: true,
        fillColor: AppTheme.darkGreyContainer,
        suffixIcon: Icon(Icons.calendar_today_rounded, color: AppTheme.greyTextColor),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
      ),
    );
  }
}
