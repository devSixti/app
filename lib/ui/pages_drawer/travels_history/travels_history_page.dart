import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TravelsHistoryPage extends StatefulWidget {
  const TravelsHistoryPage({super.key});

  @override
  State<TravelsHistoryPage> createState() => _TravelsHistoryPageState();
}

class _TravelsHistoryPageState extends State<TravelsHistoryPage> {
  final List<Map<String, dynamic>> history = [
    {
      'date': '2024/10/15 - 14:30',
      'pickUp': 'Centro Comercial Santa Fe',
      'destination': 'Universidad Nacional de Colombia',
      'price': '15000',
    },
    {
      'date': '2024/10/14 - 09:15',
      'pickUp': 'Aeropuerto José María Córdova',
      'destination': 'Hotel Intercontinental',
      'price': '65000',
    },
    {
      'date': '2024/10/13 - 16:45',
      'pickUp': 'Estadio Atanasio Girardot',
      'destination': 'Centro Comercial El Tesoro',
      'price': '22000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text(
          'Historial de viajes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: history.isNotEmpty
          ? ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final travelData = history[index];
                return TripInfoWidget(size: size, travelData: travelData);
              },
            )
          : const Center(
              child: Text(
                'No has realizado ningún viaje aún',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}

class TripInfoWidget extends StatelessWidget {
  final Map<String, dynamic> travelData;
  final Size size;

  const TripInfoWidget({
    super.key,
    required this.size,
    required this.travelData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTravelDetails(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.inputBackgroundDark,
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    travelData['date'],
                    style: TextStyle(
                      fontSize: AppTheme.smallSize,
                      fontFamily: 'XboldNexa',
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.05,
                        height: size.width * 0.05,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          travelData['pickUp'],
                          style: const TextStyle(
                            fontFamily: 'ExtraLightNexa',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.05,
                        height: size.width * 0.05,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          travelData['destination'],
                          style: const TextStyle(
                            fontFamily: 'ExtraLightNexa',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Valor carrera: \$${_formatNumber(int.tryParse(travelData['price']) ?? 0)} COP',
                    style: TextStyle(
                      fontSize: AppTheme.mediumSize,
                      fontFamily: 'XboldNexa',
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _showTravelDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          title: const Text(
            'Detalles del viaje',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fecha: ${travelData['date']}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Origen: ${travelData['pickUp']}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Destino: ${travelData['destination']}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: \$${_formatNumber(int.tryParse(travelData['price']) ?? 0)} COP',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
