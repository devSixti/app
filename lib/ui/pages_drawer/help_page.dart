import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Si tienes modo oscuro, reemplaza esto por la lógica real
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final isDrivermode = false; // Cambia esto si tienes lógica para modo conductor
    final size = MediaQuery.of(context).size;
    final textStyle = TextStyle(
      fontSize: size.width * 0.035,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('Preguntas Frecuentes'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
          width: size.width,
          decoration: BoxDecoration(
            color: AppTheme.inputBackgroundDark,
            borderRadius: BorderRadius.circular(25),
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
                title: Text(
                  isDrivermode ? 'Registro y Requisitos' : 'Registro y Cuenta',
                  style: const TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  Text(!isDrivermode ? '•\t¿Cómo me registro en el Aplicativo?' : '•\t¿Qué requisitos debo cumplir para ser conductor?', style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Debe tener una licencia de conducir válida, un seguro adecuado para su vehículo, y pasar una verificación de antecedentes. También debe cumplir con las normas locales de transporte.' : 'Para registrarse, descargue el Aplicativo, abra la aplicación y seleccione "Registrarse". Complete la información requerida, incluyendo su nombre, correo electrónico, y número de teléfono. Asegúrese de verificar su correo electrónico para activar su cuenta.', style: textStyle),
                  const SizedBox(height: 7,),
                  Text(isDrivermode ? '•\t¿Cómo puedo registrarme como conductor? ' : '•\tQué hago si olvido mi contraseña? ', 
                  style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Descargue el Aplicativo, registrese como usuario y después diríjase al "Modo Conductor" del menú lateral y complete la información requerida. Proporcione detalles sobre su vehículo y cargue los documentos necesarios para la verificación.' : 'Si olvida su contraseña, seleccione "Olvidé mi contraseña" en la pantalla de inicio de sesión y siga las instrucciones para restablecerla.', style: textStyle),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text('Seguridad', style: TextStyle(color: Colors.white)),
                children: <Widget>[
                  Text(isDrivermode ? '•\t¿Qué debo hacer si tengo problemas con un pasajero?' : '•\t¿Cómo protejo mi información personal? ', style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Si tiene problemas con un pasajero, puede reportarlo a través del Aplicativo en la sección de soporte. También puede utilizar las funciones de seguridad del Aplicativo para protegerse durante el viaje.' : 'Su información personal está protegida mediante medidas de seguridad avanzadas. No comparta su información de acceso con otros y asegúrese de cerrar sesión cuando use un dispositivo compartido.', style: textStyle),
                  const SizedBox(height: 7,),
                  Text(isDrivermode ? '•\t¿Cómo aseguro mi vehículo?' : '•\t¿Qué debo hacer si sospecho que mi cuenta ha sido comprometida? ', 
                  style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Asegúrese de que su vehículo esté en buenas condiciones y cumpla con las normas de seguridad. Realice inspecciones regulares y mantenga el seguro al día. El aplicativo no se hace responsable por accidentes de tráfica durante el uso de la app, ni por perdidas o eventos infortunados como hurtos. En caso de que algo de esto ocurra comuniquese con las autoridades pertinentes' : 'Si sospecha que su cuenta ha sido comprometida, comuníquese con el soporte del Aplicativo de inmediato para que se tomen las medidas necesarias para proteger su cuenta.', style: textStyle),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text('Pagos', style: TextStyle(color: Colors.white)),
                children: <Widget>[
                  Text(isDrivermode ? '•\t¿Cómo se calculan las comisiones? ' : '•\t¿Cómo puedo agregar un método de pago?', style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'El Aplicativo cobra una comisión sobre las tarifas de los viajes realizados. La comisión se detalla en su cuenta y se aplica automáticamente a cada viaje efectuado exitosamente.' : 'El aplicativo cuenta con diferentes métodos de pago como Nequi, bancolombia, Daviplata y pagos en efectivo. Deberá comunicar previamente al viaje cuál método de pago utilizará, la transferencia de dinero se realiza directamente al las cuentas de cada conductor.', style: textStyle),
                  const SizedBox(height: 7,),
                  Text(isDrivermode ? '•\t¿Cuándo realizar una consignación al aplicativo?' : '•\t¿Cómo se calculan las tarifas mínimas de los viajes? ', 
                  style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Diríjase a la sección "Cartera y saldos" del menú lateral, ... en construcción ...' : 'Buena pregunta.', style: textStyle),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text('Uso del Aplicativo', style: TextStyle(color: Colors.white)),
                collapsedShape: const Border(
                  top: BorderSide.none
                ),
                shape: const Border(
                  top: BorderSide.none
                ),
                children: <Widget>[
                  Text(isDrivermode ? '•\t¿Cómo acepto solicitudes de viaje? ' : '•\t¿Puedo cambiar mi ubicación de recogida después de solicitar un viaje?', style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Las solicitudes de viaje se muestran en el panel de control del Aplicativo. Puede aceptar una solicitud tocando el botón correspondiente en la pantalla.' : 'Sí, puede modificar su ubicación de recogida antes de que un conductor acepte la solicitud. Después de que haya un conductor designado, no podrá hacer cambios a su solicitud.', style: textStyle),
                  const SizedBox(height: 7,),
                  Text(isDrivermode ? '•\t¿Qué hago si no puedo aceptar una solicitud? ' : '•\t¿Qué hago si tengo problemas con mi viaje? ', 
                  style: const TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(isDrivermode ? 'Si no puede aceptar una solicitud puede ignorarla o rechazarla. En caso de haber tomado una carrera por error asegurese de notificarlo lo antes posible para evitar sanciones.' : 'Puede reportar problemas con su viaje a través del Aplicativo utilizando la opción de "Soporte" en la pantalla del viaje', style: textStyle),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: const Text(
                    'Soporte', style: TextStyle(color: Colors.white)),
                children: <Widget>[
                  const Text('•\t¿Cómo contacto al soporte del Aplicativo?', 
                  style: TextStyle(fontFamily: 'XboldNexa', color: Colors.white)),
                  const SizedBox(height: 5,),
                  Text(
                      ' Puede contactar al soporte a través de la sección “Soporte” en el Aplicativo o enviar un correo electrónico a la dirección proporcionada en la sección de contacto para conductores.',
                      style: textStyle)
                ],
              ),
            ],
          ),
        ),
      ),
      // drawer: SideMenu(
      //   scaffoldKey: scaffoldKey,
      // ),
    );
  }
}
