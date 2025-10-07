import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../drawer_menu/drawer.dart';

class MainDriverPage extends StatefulWidget {
  const MainDriverPage({super.key});

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage> {
  bool isDriverActive = false;
  bool isGpsEnabled = true;
  List<Map<String, dynamic>> services = [
    {
      'pickUp': 'Centro Comercial Santa Fe',
      'destination': 'Universidad Nacional',
      'price': '15000',
      'distance': '8.5',
      'userName': 'Carlos',
      'userRating': 4.5,
      'ratingCount': 23,
      'payMethod': 'nequi',
      'requestTime': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: Column(
          children: [
            _buildToggleButton(),
            if (!isGpsEnabled) ...[
              const SizedBox(height: 3),
              Text(
                'Activa tu ubicación',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade600,
                  height: 0,
                ),
              ),
            ],
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (BuildContext builderContext) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(builderContext).openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    color: const Color.fromRGBO(21, 21, 21, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.menu_rounded, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.02),
          child: Column(
            children: [
              // Barra de botones
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonGroupCustom('RECEPCIÓN DE SERVICIOS XISTI'),
                ],
              ),
              // Contenedor principal
              Container(
                width: double.infinity,
                height: size.height - size.height * 0.15,
                padding: EdgeInsets.symmetric(
                  vertical: size.width * 0.04,
                  horizontal: size.width * 0.02,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                  color: AppTheme.inputBackgroundDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                ),
                child: isDriverActive
                    ? ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return ServiceNotification(service);
                        },
                      )
                    : const Center(
                        child: Text(
                          'Actívate como conductor para recibir servicios',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.5,
      height: size.height * 0.055,
      decoration: BoxDecoration(
        color: AppTheme.inputBackgroundDark,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isDriverActive = true;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: size.width * 0.01),
              width: size.width * 0.24,
              height: size.height * 0.045,
              decoration: BoxDecoration(
                color: isDriverActive ? const Color.fromRGBO(20, 20, 20, 1) : null,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: isDriverActive ? AppTheme.primaryColor : Colors.white,
                    size: size.width * 0.04,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    'Libre',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: isDriverActive ? AppTheme.primaryColor : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isDriverActive = false;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: size.width * 0.01),
              padding: EdgeInsets.only(left: size.width * 0.016),
              width: size.width * 0.24,
              height: size.height * 0.045,
              decoration: BoxDecoration(
                color: !isDriverActive ? const Color.fromRGBO(20, 20, 20, 1) : null,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block,
                    color: !isDriverActive ? AppTheme.primaryColor : Colors.white,
                    size: size.width * 0.04,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    'Ocupado',
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: !isDriverActive ? AppTheme.primaryColor : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceNotification extends StatelessWidget {
  const ServiceNotification(this.serviceData, {super.key});

  final Map<String, dynamic> serviceData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        _showServiceDetails(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.008),
        padding: EdgeInsets.only(
          top: size.height * 0.02,
          bottom: size.height * 0.01,
          left: size.height * 0.01,
          right: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(21, 21, 21, 0.97),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Direcciones y precio
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pick up
                  Row(
                    children: [
                      Container(
                        width: 17,
                        height: 17,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.place, color: Colors.white, size: 12),
                      ),
                      SizedBox(width: size.width * 0.01),
                      Expanded(
                        child: Text(
                          serviceData['pickUp'],
                          style: TextStyle(
                            height: 0,
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.036,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.007),
                  // Destino
                  Row(
                    children: [
                      Container(
                        width: 17,
                        height: 17,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.place, color: Colors.white, size: 12),
                      ),
                      SizedBox(width: size.width * 0.01),
                      Expanded(
                        child: Text(
                          serviceData['destination'],
                          style: TextStyle(
                            fontSize: size.width * 0.034,
                            height: 0,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  // Precio y distancia
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.04),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '\$${_formatNumber(int.parse(serviceData['price']))} COP',
                            style: TextStyle(
                              fontSize: size.width * 0.043,
                              color: const Color.fromRGBO(29, 29, 29, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        '~${serviceData['distance']}km',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.034,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Usuario info
            Column(
              children: [
                CircleAvatar(
                  radius: size.width * 0.07,
                  backgroundColor: AppTheme.inputBackgroundDark,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  serviceData['userName'],
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    height: 0,
                    color: Colors.white,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow.shade800,
                        size: size.width * 0.03,
                      ),
                    ),
                    Text(
                      '${serviceData['userRating']} ',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '(${serviceData['ratingCount']})',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${serviceData['requestTime']} min',
                  style: TextStyle(
                    fontSize: size.width * 0.025,
                    color: Colors.white,
                  ),
                ),
                if (serviceData['payMethod'] != 'cash')
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.purpleColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      serviceData['payMethod'],
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
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

  void _showServiceDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          title: const Text(
            'Detalles del servicio',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usuario: ${serviceData['userName']}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: \$${_formatNumber(int.parse(serviceData['price']))} COP',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Distancia: ${serviceData['distance']} km',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Rechazar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Servicio aceptado')),
                );
              },
              child: Text(
                'Aceptar',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ButtonGroupCustom extends StatelessWidget {
  const ButtonGroupCustom(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        top: size.width * 0.03,
        left: size.width * 0.03,
        right: size.width * 0.03,
      ),
      height: size.height * 0.04,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(21, 21, 21, 0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}