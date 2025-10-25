import 'package:flutter/material.dart';

class ButtonGroupCustom extends StatelessWidget {
  const ButtonGroupCustom(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        top: size.width * 0.03,
        left: size.width * 0.03,
        right: size.width * 0.03,
      ),
      height: size.height * 0.04,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(21, 21, 21, 0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
