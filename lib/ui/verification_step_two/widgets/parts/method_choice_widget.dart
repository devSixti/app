import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MethodChoiceWidget extends StatelessWidget {
  final bool isSms;
  final ValueChanged<bool> onChanged;
  const MethodChoiceWidget({super.key, required this.isSms, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 8,
        children: [
          ChoiceChip(
            label: const Text('SMS'),
            selected: isSms,
            onSelected: (_) => onChanged(true),
            selectedColor: AppTheme.primaryColor,
            backgroundColor: AppTheme.darkGreyContainer,
            labelStyle: TextStyle(color: isSms ? AppTheme.whiteContainer : AppTheme.silver, fontWeight: FontWeight.w600),
          ),
          ChoiceChip(
            label: const Text('Email'),
            selected: !isSms,
            onSelected: (_) => onChanged(false),
            selectedColor: AppTheme.primaryColor,
            backgroundColor: AppTheme.darkGreyContainer,
            labelStyle: TextStyle(color: !isSms ? AppTheme.whiteContainer : AppTheme.silver, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
