import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class CustomShowField extends StatelessWidget {
  final String placeholder;
  const CustomShowField({
    Key? key,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      enabled: false,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: fieldBackground,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: secondaryBackground,
            width: 2,
          ),
        ),
      ),
    );
  }
}
