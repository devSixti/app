// Pantalla completa "Xisti" que muestra cards por cada red social
// con el estilo solicitado (fondo negro, degradados por marca, botón Seguir
// y previsualización de la última publicación).

import 'package:app/ui/drawer_menu/social_panel/social_card.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'xisti_links.dart';

class XistiPanelPage extends StatelessWidget {
  const XistiPanelPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),
            const WorkAppBar(title: 'Regresar', showBack: true),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - 12) / 2;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final link in XistiLinks.all)
                        SizedBox(
                          width: itemWidth,
                          height: 160,
                          child: SocialCard(link: link),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
