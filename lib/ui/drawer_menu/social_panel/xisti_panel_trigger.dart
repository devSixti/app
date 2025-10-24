// Trigger inferior del Drawer que muestra un texto con ícono
// "Síguenos en nuestras redes sociales" y abre el panel Xisti al tocar.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'xisti_panel_page.dart';

class XistiPanelTrigger extends StatelessWidget {
  const XistiPanelTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const XistiPanelPage(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Síguenos en nuestras redes sociales',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: AppTheme.smallSize,
                  ),
                  textAlign: TextAlign.left,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.share,
                  size: 12,
                  color: AppTheme.inputBackgroundLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
