import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onEditTap,
            child: Text(
              'Editar',
              style: TextStyle(
                color: Color(0xFF80FF00),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
