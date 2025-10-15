import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TravelsFiltersWidget extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedFilter;
  final Function(String) onSearchChanged;
  final Function(String) onFilterChanged;

  const TravelsFiltersWidget({
    super.key,
    required this.searchController,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          // Buscador
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppTheme.inputBackgroundDark,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              style: const TextStyle(
                color: AppTheme.whiteContainer,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar por destino, conductor...',
                hintStyle: TextStyle(
                  color: AppTheme.lightGreyContainer.withOpacity(0.7),
                  fontSize: 16,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                          color: AppTheme.lightGreyContainer,
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
          ),
          
          // Filtros rápidos
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildFilterChip('Todos', 'all'),
                _buildFilterChip('Completados', 'completed'),
                _buildFilterChip('Cancelados', 'cancelled'),
                _buildFilterChip('Esta Semana', 'week'),
                _buildFilterChip('Este Mes', 'month'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = selectedFilter == value;
    final color = AppTheme.silver;
    
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSelected
              ? [
                  color.withOpacity(0.3),
                  color.withOpacity(0.2),
                ]
              : [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onFilterChanged(value),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? color : color.withOpacity(0.8),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}