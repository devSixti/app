import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/form_trips/widgets/begin_button.dart';
import 'package:app/ui/widgets/drag_handle.dart';

class DriverPanel extends StatelessWidget {
  final DraggableScrollableController controller;
  final VoidCallback onBegin;

  const DriverPanel({super.key, required this.controller, required this.onBegin});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.14,
      minChildSize: 0.10,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.darkDrawerBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(1)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DragHandle(),
                  const SizedBox(height: 3),
                  const SizedBox(height: 1),
                  ComenzarButton(
                    onPressed: onBegin,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
