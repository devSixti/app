import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VerificationStepWidget extends StatelessWidget {
  final int stepNumber;
  final String title;
  final String description;
  final Widget? trailing;
  final VoidCallback? onTap;

  const VerificationStepWidget({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.description,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.inputBackgroundDark,
        borderRadius: AppTheme.border,
      ),
      child: InkWell(
        borderRadius: AppTheme.border,
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.darkGreyContainer,
              child: Text(
                stepNumber.toString(),
                style: TextStyle(color: AppTheme.purpleColor, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppTheme.whiteContainer, fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(description, style: const TextStyle(color: AppTheme.lightGreyContainer, fontSize: 13)),
                ],
              ),
            ),
            if (trailing != null) ...[
              trailing!,
              const SizedBox(width: 8),
            ],
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppTheme.silver),
          ],
        ),
      ),
    );
  }
}
