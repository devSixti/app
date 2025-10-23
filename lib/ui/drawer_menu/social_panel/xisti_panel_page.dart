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
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),
                  const WorkAppBar(title: 'Regresar', showBack: true),
                  const SizedBox(height: 4),
                  // Encabezado: solo título "Xisti" más grande, sin avatar
                  const Center(
                    child: Text(
                      'Redes sociales',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Grilla 2 columnas de cards
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 160, // Más pequeña
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final link = XistiLinks.all[index];
                    return SocialCard(link: link);
                  },
                  childCount: XistiLinks.all.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
