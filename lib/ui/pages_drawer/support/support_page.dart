import 'package:app/ui/pages_drawer/support/widget/contact.dart';
import 'package:app/ui/pages_drawer/support/widget/contact_channels_widget.dart';
import 'package:app/ui/pages_drawer/support/widget/faq_support_widget.dart';
import 'package:app/ui/pages_drawer/support/widget/support_head.dart';
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
          // Header
          const SupportHeaderWidget(),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Estado del soporte
                  const SupportStatusWidget(),
                  
                  // Canales de contacto
                  const ContactChannelsWidget(),
                  
                  // Preguntas frecuentes
                  const FaqSupportWidget(),
                  
                  // Formulario de contacto
                  const ContactFormWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}