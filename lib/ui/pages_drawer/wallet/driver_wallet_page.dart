import 'package:app/ui/pages_drawer/wallet/widget/driver_stats_widget.dart';
import 'package:app/ui/pages_drawer/wallet/widget/transactions_history_widget.dart';
import 'package:app/ui/pages_drawer/wallet/widget/wallet_actions_widget.dart';
import 'package:app/ui/pages_drawer/wallet/widget/wallet_header.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DriverWalletPage extends StatefulWidget {
  const DriverWalletPage({super.key});

  @override
  State<DriverWalletPage> createState() => _DriverWalletPageState();
}

class _DriverWalletPageState extends State<DriverWalletPage> {
  double currentBalance = 340000.0;
  double dailyEarnings = 85000.0;
  double weeklyEarnings = 450000.0;
  double monthlyEarnings = 1800000.0;
  int totalTrips = 127;

  // Transacciones del conductor
  final List<Map<String, dynamic>> driverTransactions = [
    {
      'id': '1',
      'type': 'earning',
      'description': 'Viaje completado - Centro a Aeropuerto',
      'amount': 45000.0,
      'date': '15 Oct 2024',
      'status': 'completed',
    },
    {
      'id': '2',
      'type': 'earning',
      'description': 'Viaje completado - Universidad a Mall',
      'amount': 28000.0,
      'date': '15 Oct 2024',
      'status': 'completed',
    },
    {
      'id': '3',
      'type': 'withdrawal',
      'description': 'Retiro a cuenta Bancolombia',
      'amount': -200000.0,
      'date': '14 Oct 2024',
      'status': 'completed',
    },
    {
      'id': '4',
      'type': 'earning',
      'description': 'Bonus por calificación 5 estrellas',
      'amount': 15000.0,
      'date': '13 Oct 2024',
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header con balance
          WalletHeaderWidget(),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Acciones rápidas del conductor
                  WalletActionsWidget(
                    isDriver: true,
                    onAddMoney: _showNotAvailableDialog,
                    onWithdraw: _showWithdrawDialog,
                    onTransfer: _showTransferDialog,
                    onPayments: _showEarningsDialog,
                  ),
                  
                  // Estadísticas de ganancias
                  DriverStatsWidget(
                    dailyEarnings: dailyEarnings,
                    weeklyEarnings: weeklyEarnings,
                    monthlyEarnings: monthlyEarnings,
                    totalTrips: totalTrips,
                  ),
                  
                  // Historial de ganancias
                  TransactionsHistoryWidget(
                    transactions: driverTransactions,
                    isDriver: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildActionDialog(
        'No Disponible',
        'En desarrollo',
        Icons.info_rounded,
        Colors.orange,
      ),
    );
  }

  void _showTransferDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildActionDialog(
        'No Disponible',
        'En desarrollo',
        Icons.info_rounded,
        Colors.orange,
      ),
    );
  }

  void _showEarningsDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildActionDialog(
        'No Disponible',
        'En desarrollo',
        Icons.info_rounded,
        Colors.orange,
      ),
    );
  }

  void _showNotAvailableDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildActionDialog(
        'No Disponible',
        'En desarrollo',
        Icons.info_rounded,
        Colors.orange,
      ),
    );
  }

  Widget _buildActionDialog(String title, String subtitle, IconData icon, Color color) {
    return AlertDialog(
      backgroundColor: AppTheme.inputBackgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.border,
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: AppTheme.border,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
            ),
          ),
        ],
      ),
      content: Text(
        '$subtitle\n\nEsta funcionalidad estará disponible próximamente.',
        style: const TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: AppTheme.whiteContainer,
            shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
          ),
          child: const Text('Entendido'),
        ),
      ],
    );
  }
}