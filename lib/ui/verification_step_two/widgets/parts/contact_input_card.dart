import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';

class PhoneWithPrefixFormatter extends TextInputFormatter {
  final int maxDigits;
  PhoneWithPrefixFormatter({this.maxDigits = 10});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final hasPlus = text.startsWith('+');
    final digits = text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length <= maxDigits ? digits : digits.substring(0, maxDigits);
    final resultText = hasPlus ? '+$limited' : limited;
    return TextEditingValue(text: resultText, selection: TextSelection.collapsed(offset: resultText.length));
  }
}

class ContactInputCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;
  final bool isSms;
  const ContactInputCard({super.key, required this.controller, required this.onSend, this.enabled = true, this.isSms = true});

  @override
  Widget build(BuildContext context) {
    final keyboard = isSms ? TextInputType.phone : TextInputType.emailAddress;
    final formatters = isSms ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, PhoneWithPrefixFormatter()] : <TextInputFormatter>[];
    final hint = isSms ? '+57 300 000 0000' : 'tu@correo.com';

    return Card(
      color: AppTheme.darkGreyContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              enabled: enabled,
              keyboardType: keyboard,
              inputFormatters: formatters,
              style: const TextStyle(color: AppTheme.whiteContainer),
              cursorColor: AppTheme.whiteContainer,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: AppTheme.darkGreyContainer,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: enabled ? onSend : null,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: AppTheme.whiteContainer, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: const Text('Enviar', style: TextStyle(color: AppTheme.whiteContainer)),
            ),
          ],
        ),
      ),
    );
  }
}
