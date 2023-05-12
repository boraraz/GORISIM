import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.color,
    this.image,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor, color;
  final Image? image;

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
        minimumSize: const Size(double.infinity, 60),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
