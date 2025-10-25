import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DriverToggleButton extends StatelessWidget {
  const DriverToggleButton({
    required this.isDriverActive,
    required this.onChanged,
    super.key,
  });

  final bool isDriverActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.5,
      height: size.height * 0.055,
      decoration: BoxDecoration(
        color: AppTheme.inputBackgroundDark,
        borderRadius: AppTheme.border,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onChanged(true),
            child: Container(
              margin: EdgeInsets.only(left: size.width * 0.01),
              width: size.width * 0.24,
              height: size.height * 0.045,
              decoration: BoxDecoration(
                color: isDriverActive ? const Color.fromRGBO(20, 20, 20, 1) : null,
                borderRadius: AppTheme.border,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: isDriverActive ? AppTheme.primaryColor : Colors.white,
                    size: size.width * 0.04,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    'Libre',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: isDriverActive ? AppTheme.primaryColor : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(false),
            child: Container(
              margin: EdgeInsets.only(right: size.width * 0.01),
              padding: EdgeInsets.only(left: size.width * 0.016),
              width: size.width * 0.24,
              height: size.height * 0.045,
              decoration: BoxDecoration(
                color: !isDriverActive ? const Color.fromRGBO(20, 20, 20, 1) : null,
                borderRadius: AppTheme.border,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block,
                    color: !isDriverActive ? AppTheme.primaryColor : Colors.white,
                    size: size.width * 0.04,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    'Ocupado',
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: !isDriverActive ? AppTheme.primaryColor : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
