import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedCategory = 'General';

  final List<String> _categories = [
    'General',
    'Problema Técnico',
    'Facturación',
    'Conductor',
    'Seguridad',
    'Sugerencia',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.purpleColor.withOpacity(0.1),
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.blackContainer.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.4, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppTheme.purpleColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.purpleColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.purpleColor.withOpacity(0.2),
                        AppTheme.primaryColor.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.contact_mail_rounded,
                    color: AppTheme.whiteContainer,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Enviar Mensaje',
                    style: TextStyle(
                      color: AppTheme.whiteContainer,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Nombre
            _buildTextField(
              controller: _nameController,
              label: 'Nombre completo',
              icon: Icons.person_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Email
            _buildTextField(
              controller: _emailController,
              label: 'Correo electrónico',
              icon: Icons.email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu email';
                }
                if (!value.contains('@')) {
                  return 'Ingresa un email válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Categoría
            _buildCategorySelector(),
            const SizedBox(height: 16),
            
            // Mensaje
            _buildTextField(
              controller: _messageController,
              label: 'Describe tu consulta o problema',
              icon: Icons.message_rounded,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu mensaje';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // Botón enviar
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.purpleColor.withOpacity(0.8),
                    AppTheme.primaryColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.purpleColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: _submitForm,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.send_rounded,
                          color: AppTheme.whiteContainer,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Enviar Mensaje',
                          style: TextStyle(
                            color: AppTheme.whiteContainer,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.purpleColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: const TextStyle(
          color: AppTheme.whiteContainer,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppTheme.lightGreyContainer.withOpacity(0.8),
            fontSize: 16,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.purpleColor.withOpacity(0.2),
                  AppTheme.purpleColor.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppTheme.purpleColor,
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.purpleColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.purpleColor.withOpacity(0.2),
                  AppTheme.purpleColor.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.category_rounded,
              color: AppTheme.purpleColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                dropdownColor: AppTheme.inputBackgroundDark,
                style: const TextStyle(
                  color: AppTheme.whiteContainer,
                  fontSize: 16,
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Aquí se procesaría el formulario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.primaryColor,
          content: const Text(
            'Mensaje enviado correctamente. Te contactaremos pronto.',
            style: TextStyle(color: AppTheme.blackContainer),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      
      // Limpiar formulario
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      setState(() {
        _selectedCategory = 'General';
      });
    }
  }
}