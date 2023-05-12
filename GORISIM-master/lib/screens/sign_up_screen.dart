// ignore_for_file: use_build_context_synchronously, import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'dart:convert';

import 'package:bitirme/resources/auth.methods.dart';
import 'package:bitirme/screens/login_screen.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign_up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  final _formKey = GlobalKey<FormState>();
  String url = '';

  void signUpUser() async {
    bool res = await _authMethods.signUpUser(
      context,
      _nameController.text,
      _surnameController.text,
      _emailController.text,
      _phoneController.text,
      _hashValue(sha1),
    );
    if (res) {
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.routeName,
      );
    }
  }

  String _hashValue(Hash algorithm) {
    var bytes = utf8.encode(_passwordController.text);
    return algorithm.convert(bytes).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text("GÖRİŞİM"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: primaryColor,
                    ),
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      const Text(
                        "İsim",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _nameController,
                        placeholder: 'İsim...',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Surname
                      const Text(
                        "Soyisim",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _surnameController,
                        placeholder: 'Soyisim...',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Email
                      const Text(
                        "E-mail",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        placeholder: 'E-mail...',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Name
                      const Text(
                        "Telefon Numarası",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _phoneController,
                        placeholder: 'Telefon Numarası...',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Password
                      const Text(
                        "Şifre",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        placeholder: 'Şifre...',
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: CustomButton(
                    onTap: () {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        _formKey.currentState!.save();
                        signUpUser();
                      }
                    },
                    text: 'Kayıt Ol',
                    backgroundColor: primaryButton,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
