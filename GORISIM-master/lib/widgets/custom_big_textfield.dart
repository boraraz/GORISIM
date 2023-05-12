import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class CustomBigTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  const CustomBigTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.multiline,
      minLines: 15,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: fieldBackground,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
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
