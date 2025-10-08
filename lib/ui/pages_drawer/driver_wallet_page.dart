import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class DriverWallet extends StatefulWidget {
  const DriverWallet({super.key});

  @override
  State<DriverWallet> createState() => _DriverWalletState();
}

class _DriverWalletState extends State<DriverWallet> {
  double balance = 25000.0; // Balance de ejemplo
  List<Map<String, dynamic>> movements = [
    {
      'type': 'recarga',
      'description': 'Recarga aprobada',
      'date': '15/10/2024 - 14:30',
      'value': 50000,
      'percentage': null,
      'status': 'APPROVED',
    },
    {
      'type': 'consumo',
      'description': 'Pago por viaje',
      'date': '14/10/2024 - 09:15',
      'value': -25000,
      'percentage': 15,
      'status': 'APPROVED',
    },
  ];

  Future<void> _refresh() async {
    // Simular recarga de datos
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Aquí iría la lógica real de recarga
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('Billetera', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              width: size.width,
              height: size.height * 0.2,
              margin: EdgeInsets.only(
                left: size.width * 0.07,
                right: size.width * 0.2,
                top: size.height * 0.06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tu balance',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '\$${balance.round().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} COP',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      fontSize: size.width * 0.08,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showPaymentMethodsModal(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.inputBackgroundDark,
                        borderRadius: AppTheme.border,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Depositar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: size.width,
        height: size.height * 0.52,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.07,
          vertical: size.height * 0.03,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppTheme.inputBackgroundDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Movimientos',
              style: TextStyle(
                color: Colors.white,
                fontSize: AppTheme.mediumSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: MovementsList(movements: movements, size: size),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentMethodsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const PaymentMethodsModal();
      },
    );
  }
}

class MovementsList extends StatelessWidget {
  const MovementsList({super.key, required this.size, required this.movements});

  final Size size;
  final List<Map<String, dynamic>> movements;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final movement = movements[index];
        final isIncome = movement['type'] == 'recarga';

        return Container(
          width: size.width,
          height: size.height * 0.075,
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isIncome
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: isIncome ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movement['description'],
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontFamily: 'XboldNexa',
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        movement['date'],
                        style: TextStyle(
                          fontSize: size.width * 0.034,
                          color: Colors.grey,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                movement['percentage'] != null
                    ? '${movement['percentage']}%'
                    : '-',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontFamily: 'XboldNexa',
                  color: Colors.white,
                ),
              ),
              Text(
                '\$${movement['value'].abs().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} COP',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontFamily: 'XboldNexa',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PaymentMethodsModal extends StatelessWidget {
  const PaymentMethodsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: const BoxDecoration(
        color: Color(0xFF181818),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            _buildPaymentMethodButton(
              context,
              'Bancolombia',
              'bancolombia.png',
            ),
            _buildPaymentMethodButton(context, 'Nequi', 'nequi.webp'),
            _buildPaymentMethodButton(context, 'Daviplata', 'daviplata.png'),
            _buildPaymentMethodButton(
              context,
              'Tarjeta Débito / Crédito',
              'visa_master.webp',
            ),
            _buildPaymentMethodButton(context, 'PSE', 'pse.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(
    BuildContext context,
    String text,
    String image,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Método de pago $text en desarrollo')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 13),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.inputBackgroundDark,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                child: Container(
                  color: Colors.grey,
                  child: const Icon(Icons.payment, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: AppTheme.mediumSize,
                fontFamily: 'XboldNexa',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
