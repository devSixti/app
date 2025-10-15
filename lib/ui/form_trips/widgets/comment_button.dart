// Este archivo contiene el botón de comentarios (ícono de consideraciones)

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentButton extends StatelessWidget {
  final Color? color;
  final VoidCallback onPressed;

  const CommentButton({
    super.key, this.color,
    required this.onPressed,
  });

  // Método que abre el panel deslizable
  void _openCommentPanel(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Cargar valores guardados en SharedPreferences
    final savedComment = prefs.getString('comment_text') ?? '';
    final savedPassengers = prefs.getBool('more_than_4') ?? false;
    final savedPets = prefs.getBool('pets_onboard') ?? false;

    // Controladores y estados iniciales
    final TextEditingController commentController = TextEditingController(
      text: savedComment,
    );
    bool moreThan4 = savedPassengers;
    bool petsOnBoard = savedPets;

    // showModalBottomSheet es el panel deslizable
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      isScrollControlled: true, // Permite que el panel ocupe más espacio
      backgroundColor:
          AppTheme.darkDrawerBackground, // color de fondo del panel
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ), // Bordes redondeados arriba
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom +
                    20, // Ajusta espacio para teclado
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título del panel
                  Center(
                    child: Text(
                      "Consideraciones",
                      style: const TextStyle(
                        fontSize: AppTheme.mediumSize,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(
                          255,
                          255,
                          255,
                          1,
                        ), // color del título
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campo de texto para comentarios
                  TextField(
                    controller: commentController,
                    maxLines: 4,
                    style: const TextStyle(
                      color: AppTheme.inputBackgroundLight,
                    ), // color del texto que escribe el usuario
                    decoration: InputDecoration(
                      hintText: "Comentarios",
                      hintStyle: const TextStyle(
                        color: AppTheme.inputBackgroundLight
                      ), // color del texto placeholder
                      filled: true,
                      fillColor:
                          Colors.grey[800], // color de fondo del campo de texto
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // sin borde visible
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Switch: Más de 4 pasajeros
                  SwitchListTile(
                    title: const Text(
                      "Más de 4 pasajeros",
                      style: TextStyle(
                        color: Colors.white,), // color del texto del switch
                    ),
                    value: moreThan4,
                    activeThumbColor: AppTheme.purpleColor, // color cuando está activado
                    inactiveThumbColor: AppTheme.lightPrimaryContainer, // color del switch apagado
                    onChanged: (value) {
                      setState(() {
                        moreThan4 = value;
                      });
                    },
                  ),

                  // Switch: Mascotas a bordo
                  SwitchListTile(
                    title: const Text(
                      "Mascotas a bordo",
                      style: TextStyle(
                        color: Colors.white,
                      ), // color del texto del switch
                    ),
                    value: petsOnBoard,
                    activeThumbColor: AppTheme.purpleColor, // color cuando está activado
                    inactiveThumbColor: AppTheme.lightPrimaryContainer, // color del switch apagado
                    onChanged: (value) {
                      setState(() {
                        petsOnBoard = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Botón "Listo"
                  Center(
                    child: SizedBox(
                      width: 200, // tamaño fijo del botón
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor, // color de fondo del botón
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppTheme.border,
                          ), // bordes redondeados del botón
                        ),
                        onPressed: () async {
                          // Guardar datos en SharedPreferences
                          await prefs.setString(
                            'comment_text',
                            commentController.text,
                          );
                          await prefs.setBool('more_than_4', moreThan4);
                          await prefs.setBool('pets_onboard', petsOnBoard);

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context); // Cerrar panel
                        },
                        child: const Text(
                          "Listo",
                          style: TextStyle(
                            color: AppTheme.blackContainer, // color del texto del botón
                            fontWeight: FontWeight.bold,
                            fontSize: AppTheme.mediumSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(0,223,3,3,), // Evita fondo blanco en Material
      child: InkWell(
        borderRadius: AppTheme.border,
        onTap: () => _openCommentPanel(context), // Al presionar abre el panel
        child: Container(
          padding: const EdgeInsets.all(12), // Padding interno del botón
          decoration: BoxDecoration(
            color: const Color.fromARGB(
              0,
              209,
              53,
              53,
            ), // El botón no tiene fondo, solo el icono
            borderRadius: AppTheme.border,
          ),
          child: Icon(
            Icons.chat_rounded, // Icono de conversación
            color: AppTheme.lightPrimaryContainer, // Color del ícono
            size: 28,
          ),
        ),
      ),
    );
  }
}