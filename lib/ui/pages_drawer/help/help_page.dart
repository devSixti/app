import 'package:app/ui/pages_drawer/help/widget/contact_widget.dart';
import 'package:app/ui/pages_drawer/help/widget/faq_widget.dart';
import 'package:app/ui/pages_drawer/help/widget/help_search_widget.dart';
import 'package:app/ui/pages_drawer/help/widget/quick_categories_widget.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredFaqItems = [];
  
  final List<Map<String, dynamic>> faqItems = [
    {
      'question': '¿Cómo puedo cambiar mi método de pago?',
      'answer': 'Puedes cambiar tu método de pago dirigiéndote a la sección "Billetera" en el menú principal, luego selecciona "Métodos de pago" y agrega o modifica tus opciones de pago preferidas.',
      'category': 'Pagos',
    },
    {
      'question': '¿Qué hago si mi conductor canceló el viaje?',
      'answer': 'Si tu conductor cancela el viaje, no te preocupes. El sistema automáticamente buscará otro conductor disponible cerca de ti. Si no encuentra uno inmediatamente, puedes intentar solicitar un nuevo viaje.',
      'category': 'Viajes',
    },
    {
      'question': '¿Cómo actualizar mi información personal?',
      'answer': 'Ve a "Configuración" en el menú lateral, selecciona "Editar Perfil" donde podrás actualizar tu nombre, teléfono, email y foto de perfil de manera segura.',
      'category': 'Cuenta',
    },
    {
      'question': '¿Es seguro compartir mi ubicación?',
      'answer': 'Sí, tu ubicación está completamente segura. Solo la utilizamos para conectarte con conductores cercanos y mejorar tu experiencia. Nunca compartimos tu ubicación con terceros sin tu consentimiento.',
      'category': 'Seguridad',
    },
    {
      'question': '¿Cómo puedo contactar al conductor?',
      'answer': 'Durante el viaje, puedes contactar a tu conductor a través del botón "Llamar" o "Mensaje" que aparece en la pantalla principal. Todas las comunicaciones están protegidas por privacidad.',
      'category': 'Viajes',
    },
    {
      'question': '¿Qué hacer si olvidé algo en el vehículo?',
      'answer': 'Si olvidaste algo, contacta inmediatamente al conductor a través de la aplicación. También puedes reportar el objeto perdido en "Soporte" y te ayudaremos a recuperarlo.',
      'category': 'Soporte',
    },
    {
      'question': '¿Cómo calificar a mi conductor?',
      'answer': 'Al finalizar cada viaje, aparecerá automáticamente una pantalla para calificar tu experiencia. Puedes dar de 1 a 5 estrellas y agregar comentarios opcionales.',
      'category': 'Viajes',
    },
    {
      'question': '¿Por qué se cobró una tarifa diferente?',
      'answer': 'El precio puede variar por factores como tráfico, demanda alta, distancia real recorrida, o tarifas nocturnas. Siempre puedes revisar el desglose del costo en tu historial de viajes.',
      'category': 'Pagos',
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredFaqItems = faqItems;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFaqItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFaqItems = faqItems;
      } else {
        filteredFaqItems = faqItems.where((item) {
          return item['question']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item['answer'].toLowerCase().contains(query.toLowerCase()) ||
              item['category'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      filteredFaqItems = faqItems.where((item) {
        return item['category'].toLowerCase() == category.toLowerCase();
      }).toList();
      _searchController.text = category;
    });
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const WorkAppBar(
                    title: 'Regresar',
                    showBack: true,
                  ),
                  const SizedBox(height: 20),
                  // Buscador
                  HelpSearchWidget(
                    searchController: _searchController,
                    onSearchChanged: _filterFaqItems,
                  ),
                  
                  // Categorías rápidas
                  QuickCategoriesWidget(
                    onCategorySelected: _filterByCategory,
                  ),
                  
                  // Preguntas frecuentes
                  FaqWidget(
                    filteredFaqItems: filteredFaqItems,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Widget de contacto
                  const ContactWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}