import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsSelectorWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String currentValue;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final IconData icon;
  final Color accentColor;

  const SettingsSelectorWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentValue,
    required this.options,
    required this.onChanged,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showOptionsDialog(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.whiteContainer,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppTheme.lightGreyContainer,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: accentColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    currentValue,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: accentColor.withOpacity(0.6),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: accentColor.withOpacity(0.3)),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: currentValue == option 
                    ? accentColor.withOpacity(0.1)
                    : AppTheme.blackContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: currentValue == option 
                      ? accentColor.withOpacity(0.5)
                      : accentColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      onChanged(option);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            currentValue == option 
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_unchecked_rounded,
                            color: currentValue == option 
                              ? accentColor 
                              : AppTheme.lightGreyContainer,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                color: currentValue == option 
                                  ? accentColor 
                                  : AppTheme.whiteContainer,
                                fontSize: 16,
                                fontWeight: currentValue == option 
                                  ? FontWeight.w600 
                                  : FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}