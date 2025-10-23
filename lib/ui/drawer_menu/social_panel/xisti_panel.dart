// Este archivo Muestra un handle, un botón de regresar morado en la parte superior izquierda.
// Handle superior para dar sensación de sheet arrastrable

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'xisti_links.dart';
import 'social_item_tile.dart';

class XistiPanel extends StatelessWidget {
  const XistiPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      child: Container(
        color: AppTheme.darkDrawerBackground,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle superior para dar sensación de sheet arrastrable
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Usa el WorkAppBar existente con estilo "≪ Regresar"
              const WorkAppBar(title: 'Regresar', showBack: true),
              const SizedBox(height: 14),
              
              const Text(
                'Xisti',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: AppTheme.mediumSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => SocialItemTile(
                    link: XistiLinks.all[index],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: XistiLinks.all.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
