import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsHeaderWidget extends StatelessWidget {
  const SettingsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: AppTheme.darkDrawerBackground,
      surfaceTintColor: AppTheme.darkDrawerBackground,
      shadowColor: AppTheme.darkDrawerBackground,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: const Text(
            'Configuración',
            style: TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: AppTheme.mediumSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            color: AppTheme.darkDrawerBackground,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // Icono principal mejorado
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primaryColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.settings,
                      color: AppTheme.primaryColor,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
