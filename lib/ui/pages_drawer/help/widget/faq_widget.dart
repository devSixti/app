import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'faq_item_widget.dart';

class FaqWidget extends StatelessWidget {
  final List<Map<String, dynamic>> filteredFaqItems;

  const FaqWidget({
    super.key,
    required this.filteredFaqItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.silver,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackContainer.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.silver.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.quiz_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Preguntas Frecuentes',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.border,
                  border: Border.all(
                    color: AppTheme.silver,
                    width: 1,
                  ),
                ),
                child: Text(
                  '${filteredFaqItems.length}',
                  style: const TextStyle(
                    color: AppTheme.silver,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (filteredFaqItems.isNotEmpty)
            ...filteredFaqItems.map((item) {
              int index = filteredFaqItems.indexOf(item);
              var faqItemWidget = FaqItemWidget(
                question: item['question'],
                answer: item['answer'],
                category: item['category'],
                index: index,
              );
              return faqItemWidget;
            })
          else
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.silver.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search_off_rounded,
                      color: AppTheme.silver,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No se encontraron resultados',
                    style: TextStyle(
                      color: AppTheme.whiteContainer,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Intenta con otras palabras clave o contacta nuestro soporte',
                    style: TextStyle(
                      color: AppTheme.lightGreyContainer,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}