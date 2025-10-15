import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SecurityHeaderWidget extends StatelessWidget {
  const SecurityHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: AppTheme.darkGreyContainer,
      surfaceTintColor: AppTheme.darkGreyContainer,
      shadowColor: AppTheme.darkGreyContainer,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,

        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: const Text(
            'Seguridad',
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
            color: AppTheme.darkGreyContainer,
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
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.security_rounded,
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
