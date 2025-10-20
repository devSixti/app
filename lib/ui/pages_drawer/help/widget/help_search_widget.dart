import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HelpSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const HelpSearchWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: AppTheme.border,
      ),
      child: TextField(
        controller: searchController,
        onChanged: onSearchChanged,
        style: TextStyle(
          color: AppTheme.whiteContainer,
          fontSize: AppTheme.mediumSize,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar en preguntas frecuentes...',
          hintStyle: TextStyle(
            color: AppTheme.whiteContainer,
            fontSize: AppTheme.mediumSize,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: AppTheme.border,
            ),
            child: const Icon(
              Icons.search_rounded,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged('');
                  },
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: AppTheme.whiteContainer,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}