// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bitirme/resources/auth.methods.dart';
import 'package:bitirme/screens/account_edit.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/custom_textfield.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class PasswordChangeForgotScreen extends StatefulWidget {
  static const String routeName = '/password__forgot_change';
  const PasswordChangeForgotScreen({Key? key}) : super(key: key);

  @override
  State<PasswordChangeForgotScreen> createState() =>
      _PasswordChangeForgotScreenState();
}

class _PasswordChangeForgotScreenState
    extends State<PasswordChangeForgotScreen> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _newPassRepController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  final _formKey = GlobalKey<FormState>();
  String password = '';

  String _hashValue(Hash algorithm, TextEditingController controller) {
    var bytes = utf8.encode(controller.text);
    return algorithm.convert(bytes).toString();
  }

  void changePass() async {
    if (_newPassController.text == _newPassRepController.text) {
      bool res = await _authMethods.updatePass(
        context,
        _hashValue(sha1, _newPassController),
      );

      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Parola Başarıyla Değiştirildi!'),
          ),
        );
        Navigator.pushReplacementNamed(context, AccountEditScreen.routeName);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yeni parolalar eşleşmiyor'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hesap Bilgileri"),
        titleTextStyle: const TextStyle(
          color: secondaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: secondaryBackground,
        iconTheme: const IconThemeData(
          color: secondaryColor,
          size: 35.0,
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.close, size: 50.0),
            onPressed: () {
              showAlertDialog(context);
            },
          );
        }),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Parola Yenileme',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Yeni Parola',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    CustomTextField(
                      controller: _newPassController,
                      placeholder: 'Yeni Parola...',
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Yeni Parola Tekrar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    CustomTextField(
                      controller: _newPassRepController,
                      placeholder: 'Yeni Parola Tekrar...',
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButton(
                onTap: changePass,
                text: 'Onayla',
                backgroundColor: primaryButton,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.black,
        backgroundColor: secondaryButton,
        minimumSize: const Size(60, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: Colors.red),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Vazgeç"),
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        minimumSize: const Size(60, 60),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: () {
        Navigator.pushNamed(context, AccountEditScreen.routeName);
      },
      child: const Text("Çık"),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Hesap Bilgileri"),
      content:
          const Text("Parola yenilemeden çıkmak istediğinize emin misiniz?"),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cancelButton,
              const SizedBox(
                width: 20,
              ),
              continueButton,
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
