import 'package:app/ui/pages_drawer/travels_history/widget/list.dart';
import 'package:app/ui/pages_drawer/travels_history/widget/stast.dart';
import 'package:app/ui/pages_drawer/travels_history/widget/travels_filters_widget.dart';
import 'package:app/ui/pages_drawer/travels_history/widget/travels_header_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';


class TravelsHistoryPage extends StatefulWidget {
  const TravelsHistoryPage({super.key});

  @override
  State<TravelsHistoryPage> createState() => _TravelsHistoryPageState();
}

class _TravelsHistoryPageState extends State<TravelsHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'all';
  List<Map<String, dynamic>> filteredTrips = [];

  // Datos de ejemplo
  final List<Map<String, dynamic>> allTrips = [
    {
      'id': '1',
      'date': '15 Oct 2024',
      'time': '2:30 PM',
      'from': 'Centro Comercial Santafé',
      'to': 'Universidad Nacional',
      'driverName': 'Carlos Mendoza',
      'driverPhoto': 'https://randomuser.me/api/portraits/men/1.jpg',
      'rating': 4.8,
      'price': 25000,
      'duration': 32,
      'status': 'completed',
    },
    {
      'id': '2',
      'date': '14 Oct 2024',
      'time': '8:15 AM',
      'from': 'Aeropuerto El Dorado',
      'to': 'Hotel Dann Carlton',
      'driverName': 'María García',
      'driverPhoto': 'https://randomuser.me/api/portraits/women/2.jpg',
      'rating': 4.9,
      'price': 45000,
      'duration': 28,
      'status': 'completed',
    },
    {
      'id': '3',
      'date': '12 Oct 2024',
      'time': '6:45 PM',
      'from': 'Zona Rosa',
      'to': 'Chapinero Norte',
      'driverName': 'Luis Rodríguez',
      'driverPhoto': 'https://randomuser.me/api/portraits/men/3.jpg',
      'rating': 4.7,
      'price': 18000,
      'duration': 15,
      'status': 'cancelled',
    },
    {
      'id': '4',
      'date': '10 Oct 2024',
      'time': '11:20 AM',
      'from': 'Terminal de Transporte',
      'to': 'Centro Histórico',
      'driverName': 'Ana Martínez',
      'driverPhoto': 'https://randomuser.me/api/portraits/women/4.jpg',
      'rating': 5.0,
      'price': 22000,
      'duration': 25,
      'status': 'completed',
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredTrips = allTrips;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTrips() {
    List<Map<String, dynamic>> filtered = allTrips;

    // Filtrar por texto de búsqueda
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((trip) {
        return trip['from'].toString().toLowerCase().contains(query) ||
               trip['to'].toString().toLowerCase().contains(query) ||
               trip['driverName'].toString().toLowerCase().contains(query);
      }).toList();
    }

    // Filtrar por categoría
    switch (selectedFilter) {
      case 'completed':
        filtered = filtered.where((trip) => trip['status'] == 'completed').toList();
        break;
      case 'cancelled':
        filtered = filtered.where((trip) => trip['status'] == 'cancelled').toList();
        break;
      case 'week':
        // Filtrar última semana (simulado)
        filtered = filtered.take(3).toList();
        break;
      case 'month':
        // Filtrar último mes (simulado)
        break;
    }

    setState(() {
      filteredTrips = filtered;
    });
  }

  void _onSearchChanged(String query) {
    _filterTrips();
  }

  void _onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    _filterTrips();
  }

  void _onTripTap(Map<String, dynamic> trip) {
    _showTripDetailsDialog(trip);
  }

  void _showTripDetailsDialog(Map<String, dynamic> trip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3)),
          ),
          title: Text(
            'Detalles del Viaje',
            style: const TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Fecha:', trip['date']),
              _buildDetailRow('Hora:', trip['time']),
              _buildDetailRow('Desde:', trip['from']),
              _buildDetailRow('Hasta:', trip['to']),
              _buildDetailRow('Conductor:', trip['driverName']),
              _buildDetailRow('Precio:', '\$${trip['price']}'),
              _buildDetailRow('Duración:', '${trip['duration']} min'),
              _buildDetailRow('Estado:', trip['status']),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.blackContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.lightGreyContainer,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.whiteContainer,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calcular estadísticas
    final totalTrips = allTrips.length;
    final completedTrips = allTrips.where((trip) => trip['status'] == 'completed').toList();
    final totalSpent = completedTrips.fold<double>(
      0.0, 
      (sum, trip) => sum + (trip['price'] as int).toDouble()
    ) / 1000; // Convertir a miles
    final thisMonth = allTrips.length; // Simplificado para el ejemplo

    return Scaffold(
      backgroundColor: AppTheme.darkGreyContainer,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          const TravelsHeaderWidget(),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Estadísticas
                  TravelsStatsWidget(
                    totalTrips: totalTrips,
                    totalSpent: totalSpent,
                    thisMonth: thisMonth,
                  ),
                  
                  // Filtros y búsqueda
                  TravelsFiltersWidget(
                    searchController: _searchController,
                    selectedFilter: selectedFilter,
                    onSearchChanged: _onSearchChanged,
                    onFilterChanged: _onFilterChanged,
                  ),
                  
                  // Lista de viajes
                  TravelsListWidget(
                    trips: filteredTrips,
                    onTripTap: _onTripTap,
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