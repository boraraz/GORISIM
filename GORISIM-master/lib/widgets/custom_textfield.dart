import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool isPassword;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
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
      validator: (
        String? value,
      ) {
        if (value == null || value.isEmpty) {
          return 'Bu alan boş bırakılamaz!';
        }
        if (placeholder == 'E-mail...' || placeholder == 'E-posta...') {
          String pattern = r'\w+@\w+\.\w+';
          if (!RegExp(pattern).hasMatch(value)) {
            return 'Geçerli bir e-posta adresi giriniz!';
          }
        }
        if (placeholder == 'Şifre...' ||
            placeholder == 'Eski Parola...' ||
            placeholder == 'Yeni Parola...' ||
            placeholder == 'Yeni Parola Tekrar...') {
          String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,20}$';
          if (!RegExp(pattern).hasMatch(value)) {
            return 'Şifreniz en az 8 karakter, bir büyük harf, bir küçük harf ve bir rakam içermelidir!';
          }
          if (value.length < 8) {
            return 'Şifreniz en az 8 karakter olmalıdır!';
          }
        }
        if (placeholder == 'Telefon Numarası...') {
          String pattern = r'^(?=.*?[0-9]).{10}$';
          if (!RegExp(pattern).hasMatch(value)) {
            return 'Telefon numaranızı başında 0 olmadan giriniz (5XX XXX XX XX) !';
          }
        }
        if (placeholder == '6 haneli doğrulama kodu...') {
          String pattern = r'^(?=.*?[0-9]).{6}$';
          if (!RegExp(pattern).hasMatch(value)) {
            return 'Doğrulama kodunu 6 haneli olarak giriniz!';
          }
        }
        return null;
      },
    );
  }
}
