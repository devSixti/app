import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.purpleLight, // Borde morado
            width: 2.0,
          ),
          borderRadius: AppTheme.border,
        ),
        child: Material(
          color: AppTheme.transparent,
          child: InkWell(
            onTap: () {
              if (onPressed != null) {
                onPressed!();
              } else {
                Navigator.pop(context);
              }
            },
            borderRadius: AppTheme.border,
            child: SizedBox(
              child: const Center(
                child: Icon(
                  Icons.chevron_left,
                  color: AppTheme.purpleLight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
