// Pantalla principal de búsqueda de conductor
// Muestra la interfaz mientras se busca un conductor disponible

import 'package:app/ui/searching_driver/widgets/cancellation/cancellation_reason.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/map/map_widget.dart';
import 'widgets/search_title.dart';
import 'widgets/price_payment_card.dart';
import 'widgets/auto_accept_switch.dart';
import 'widgets/current_request_section.dart';
import 'widgets/cancel_request_button.dart';

class SearchingDriverView extends StatefulWidget {
  final String startLocation;
  final String endLocation;
  final double offeredPrice;
  final String paymentMethod;

  const SearchingDriverView({
    super.key,
    required this.startLocation,
    required this.endLocation,
    required this.offeredPrice,
    this.paymentMethod = 'Efectivo',
  });

  @override
  State<SearchingDriverView> createState() => _SearchingDriverViewState();
}

class _SearchingDriverViewState extends State<SearchingDriverView> {
  bool autoAccept = true;
  late double currentPrice;

  @override
  void initState() {
    super.initState();
    currentPrice = widget.offeredPrice;
  }

  void _incrementPrice(double amount) {
    setState(() {
      currentPrice += amount;
    });
  }

  void _cancelRequest(CancellationReason reason) {
    // Aquí puedes agregar lógica adicional con la razón de cancelación
    // Por ejemplo: enviar la razón al backend, mostrar un mensaje, etc.
    debugPrint('Servicio cancelado. Razón: ${reason.title}');
    
    // Cerrar la pantalla
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: AppTheme.whiteContainer,
          ),
          onPressed: () {
            // Aquí puedes agregar la funcionalidad del menú si es necesario
          },
        ),
      ),
      body: Stack(
        children: [
          // Mapa en el fondo
          const Positioned.fill(
            child: MapScreen(),
          ),
          
          // Panel deslizable con el contenido
          DraggableScrollableSheet(
            initialChildSize: 0.63,
            minChildSize: 0.40,
            maxChildSize: 0.70,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(  
                  color: AppTheme.darkDrawerBackground,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12.0),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    // Indicador de arrastre
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.silver.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    
                    // Título principal
                    const SearchTitle(),
                    
                    const SizedBox(height: 12),
                    
                    // Tarjeta de precio y pago
                    PricePaymentCard(
                      currentPrice: currentPrice,
                      paymentMethod: widget.paymentMethod,
                      onIncrementPrice: _incrementPrice,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Switch de aceptación automática
                    AutoAcceptSwitch(
                      value: autoAccept,
                      onChanged: (value) {
                        setState(() {
                          autoAccept = value;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Sección de solicitud actual
                    CurrentRequestSection(
                      startLocation: widget.startLocation,
                      endLocation: widget.endLocation,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Botón de cancelar (oculto inicialmente, visible al hacer scroll)
                    Center(
                      child: CancelRequestButton(
                        onCancellationConfirmed: _cancelRequest,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
