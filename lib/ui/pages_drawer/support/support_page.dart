import 'package:app/ui/pages_drawer/support/widget/contact_channels_widget.dart';
import 'package:app/ui/pages_drawer/support/widget/faq_support_widget.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/pages_drawer/support/widget/support_status_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';


class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

      
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const WorkAppBar(
                    title: 'Regresar',
                    showBack: true,
                  ),
                  const SizedBox(height: 20),
                  // Canales de contacto
                  const ContactChannelsWidget(),
                  
                  // Preguntas frecuentes
                  const FaqSupportWidget(),
                  
                  // Estado del soporte
                  const SupportStatusWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}