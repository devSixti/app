import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DriverServiceCard extends StatelessWidget {
  const DriverServiceCard({required this.service, super.key});

  final Map<String, dynamic> service;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => _showServiceDetails(context),
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
                        child: const Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      SizedBox(width: size.width * 0.01),
                      Expanded(
                        child: Text(
                          service['pickUp'],
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
                        child: const Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      SizedBox(width: size.width * 0.01),
                      Expanded(
                        child: Text(
                          service['destination'],
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '\$${_formatNumber(int.parse(service['price']))} COP',
                            style: TextStyle(
                              fontSize: size.width * 0.043,
                              color: const Color.fromRGBO(29, 29, 29, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        '~${service['distance']}km',
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
                  service['userName'],
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
                      '${service['userRating']} ',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '(${service['ratingCount']})',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${service['requestTime']} min',
                  style: TextStyle(
                    fontSize: size.width * 0.025,
                    color: Colors.white,
                  ),
                ),
                if (service['payMethod'] != 'cash')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.purpleColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      service['payMethod'],
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
                'Usuario: ${service['userName']}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: \$${_formatNumber(int.parse(service['price']))} COP',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Distancia: ${service['distance']} km',
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
