import 'package:flutter/material.dart';

class CustomLittleButton extends StatelessWidget {
  const CustomLittleButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.backgroundColor,
      required this.color})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor, color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: color,
        backgroundColor: backgroundColor,
        minimumSize: const Size(50, 60),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
