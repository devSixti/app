import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: AppTheme.mediumSize,
    );

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Ayuda y Soporte',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.inputBackgroundDark,
            borderRadius: AppTheme.border,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpansionTile(
                title: const Text(
                  'Registro y Cuenta',
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  const Text(
                    '•\t¿Cómo me registro en el Aplicativo?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Para registrarse, descargue el Aplicativo, abra la aplicación y seleccione "Registrarse". Complete la información requerida, incluyendo su nombre, correo electrónico, y número de teléfono. Asegúrese de verificar su correo electrónico para activar su cuenta.',
                    style: textStyle,
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    '•\t¿Qué hago si olvido mi contraseña?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Si olvida su contraseña, seleccione "Olvidé mi contraseña" en la pantalla de inicio de sesión y siga las instrucciones para restablecerla.',
                    style: textStyle,
                  ),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text(
                  'Seguridad',
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  const Text(
                    '•\t¿Cómo protejo mi información personal?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Su información personal está protegida mediante medidas de seguridad avanzadas. No comparta su información de acceso con otros y asegúrese de cerrar sesión cuando use un dispositivo compartido.',
                    style: textStyle,
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    '•\t¿Qué debo hacer si sospecho que mi cuenta ha sido comprometida?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Si sospecha que su cuenta ha sido comprometida, comuníquese con el soporte del Aplicativo de inmediato para que se tomen las medidas necesarias para proteger su cuenta.',
                    style: textStyle,
                  ),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text(
                  'Pagos',
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  const Text(
                    '•\t¿Cómo puedo agregar un método de pago?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'El aplicativo cuenta con diferentes métodos de pago como Nequi, Bancolombia, Daviplata y pagos en efectivo. Deberá comunicar previamente al viaje cuál método de pago utilizará, la transferencia de dinero se realiza directamente a las cuentas de cada conductor.',
                    style: textStyle,
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    '•\t¿Cómo se calculan las tarifas mínimas de los viajes?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Las tarifas se calculan según la distancia, tiempo del viaje y demanda en la zona. Puede ver el estimado de tarifa antes de confirmar su viaje.',
                    style: textStyle,
                  ),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text(
                  'Servicios de Viaje',
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  const Text(
                    '•\t¿Puedo cambiar mi ubicación de recogida después de solicitar un viaje?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Sí, puede cambiar su ubicación de recogida antes de que el conductor llegue. Vaya a los detalles del viaje y actualice la ubicación de recogida.',
                    style: textStyle,
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    '•\t¿Qué hago si tengo problemas con mi viaje?',
                    style: TextStyle(
                      fontFamily: 'XboldNexa',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Si tiene problemas durante el viaje, puede usar la función de ayuda en la aplicación o comunicarse con el soporte al cliente. Su seguridad es nuestra prioridad.',
                    style: textStyle,
                  ),
                ],
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '¿Necesita más ayuda?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppTheme.mediumSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Contáctenos en soporte@xisti.com\no llame al +57 123 456 7890',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: AppTheme.mediumSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
