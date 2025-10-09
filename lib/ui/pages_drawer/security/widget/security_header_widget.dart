import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SecurityHeaderWidget extends StatelessWidget {
  const SecurityHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220.0,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.darkScaffold,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.blackContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, 
            color: AppTheme.whiteContainer),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.purpleColor.withOpacity(0.15),
                AppTheme.primaryColor.withOpacity(0.15),
                AppTheme.inputBackgroundDark,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.purpleColor.withOpacity(0.3),
                      AppTheme.primaryColor.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.purpleColor.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.purpleColor.withOpacity(0.2),
                        AppTheme.primaryColor.withOpacity(0.2),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
                    color: AppTheme.whiteContainer,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Seguridad',
                style: TextStyle(
                  color: AppTheme.whiteContainer,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.blackContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.purpleColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Tu protección es nuestra prioridad',
                  style: TextStyle(
                    color: AppTheme.lightGreyContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}