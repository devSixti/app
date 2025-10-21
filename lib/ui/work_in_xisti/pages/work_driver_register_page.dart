// Pantalla de registro de conductor dentro del módulo "Trabaja en Xisti".
// Muestra el progreso de registro de documentos y un botón para continuar.
// Desde aquí el conductor puede acceder a las diferentes etapas del proceso de registro.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/pages/work_basic_info_page.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/pages/work_identity_document_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Página principal del registro de conductor.
// Se convierte a StatefulWidget para poder reflejar el estado de pasos completados.
class WorkDriverRegisterPage extends StatefulWidget {
  final String vehicleType; // Carro o Moto

  const WorkDriverRegisterPage({
    super.key,
    required this.vehicleType,
  });

  @override
  State<WorkDriverRegisterPage> createState() => _WorkDriverRegisterPageState();
}

class _WorkDriverRegisterPageState extends State<WorkDriverRegisterPage> {
  // Flag de estado: indica si la sección "Información Básica" fue completada.
  bool _basicInfoCompleted = false;
  // Flag de estado: indica si la sección "Documento de Identidad" fue completada.
  bool _identityCompleted = false;

  @override
  void initState() {
    super.initState();
    // Al abrir la pantalla, cargamos el estado persistente del paso "Información Básica".
    _loadCompletionFlag();
    _loadIdentityFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior con el título dinámico según el tipo de vehículo.
            WorkAppBar(
              title: 'Registro Conductor (${widget.vehicleType})',
              showBack: true,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lista de pasos del registro con las mismas bolitas en todos los ítems.
                    GestureDetector(
                      // Al tocar "Información Básica" navegamos a la pantalla y esperamos resultado.
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkBasicInfoPage(vehicleType: widget.vehicleType),
                          ),
                        );
                        // Si la pantalla de info básica retorna true, marcamos el paso como completado.
                        if (completed == true) {
                          setState(() => _basicInfoCompleted = true);
                        }
                      },
                      child: _buildRegisterItem('Información Básica', completed: _basicInfoCompleted),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkIdentityDocumentPage(vehicleType: widget.vehicleType),
                          ),
                        );
                        if (completed == true) {
                          setState(() => _identityCompleted = true);
                        }
                      },
                      child: _buildRegisterItem('Documento de Identidad', completed: _identityCompleted),
                    ),
                    _buildRegisterItem('Licencia'),
                    _buildRegisterItem('Certificado de antecedentes'),
                    _buildRegisterItem('SOAT'),
                    _buildRegisterItem('Información de vehículo'),

                    const Spacer(),

                    // Botón principal "Continuar"
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Continuar',
                          style: TextStyle(
                            color: AppTheme.blackContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Texto legal informativo al final de la pantalla
                    Transform.translate(
                      offset: const Offset(0, -35),
                      child: Text(
                        'Al presionar “continuar”, acepto los Términos y condiciones de Xisti, además acepto el procesamiento y transferencia de datos personales según nuestra Política de privacidad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.greyTextColor,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método que construye cada ítem de la lista del registro.
  // Todas las bolitas tienen el mismo diseño (sin check, sin doble icono).
  // Ítem de la lista de pasos de registro.
  // Si completed = true, muestra un ícono de check; de lo contrario, una bolita vacía.
  static Widget _buildRegisterItem(String title, {bool completed = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Texto del ítem
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: AppTheme.whiteContainer,
                fontSize: 15,
              ),
            ),
          ),

          // Ícono circular (misma bolita para todos)
          // Si el paso está completado, mostramos un check con color principal.
          // Si no, mostramos la bolita actual con opacidad.
          Icon(
            completed ? Icons.check_circle : Icons.circle_outlined,
            color: completed ? AppTheme.primaryColor : AppTheme.whiteContainer.withOpacity(0.4),
            size: 22,
          ),
        ],
      ),
    );
  }

  // Lee desde SharedPreferences si el paso de Información Básica ya fue completado
  // para el tipo de vehículo actual y actualiza el estado.
  Future<void> _loadCompletionFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('basic_info_completed_${widget.vehicleType}') ?? false;
    if (mounted) {
      setState(() => _basicInfoCompleted = saved);
    }
  }

  Future<void> _loadIdentityFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('identity_completed_${widget.vehicleType}') ?? false;
    if (mounted) {
      setState(() => _identityCompleted = saved);
    }
  }
}
