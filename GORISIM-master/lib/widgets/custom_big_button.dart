import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton(
      {Key? key, required this.onTap, required this.text, this.image})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: bigButtonBackground,
        minimumSize: const Size(double.infinity, 300),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: onTap,
      child: Column(
        children: [
          Image.asset(image!, height: 300, width: double.infinity),
          Text(text),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
