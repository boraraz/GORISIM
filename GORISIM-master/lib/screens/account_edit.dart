// ignore_for_file: use_build_context_synchronously

import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/resources/auth.methods.dart';
import 'package:bitirme/screens/account_info.dart';
import 'package:bitirme/screens/password_change_screen.dart';
import 'package:bitirme/widgets/custom_little_button.dart';
import 'package:bitirme/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:provider/provider.dart';

class AccountEditScreen extends StatefulWidget {
  static const String routeName = '/account_edit';
  const AccountEditScreen({Key? key}) : super(key: key);

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  String nameSurname = "";

  updateUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_nameController.text == "") {
      _nameController.text = userProvider.user.name;
    }
    if (_surnameController.text == "") {
      _surnameController.text = userProvider.user.surname;
    }
    if (_emailController.text == "") {
      _emailController.text = userProvider.user.email;
    }
    if (_phoneController.text == "") {
      _phoneController.text = userProvider.user.phone;
    }
    bool res = await _authMethods.updateUserInfo(
      context,
      _nameController.text,
      _surnameController.text,
      _phoneController.text,
      _emailController.text,
    );

    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bilgiler Başarıyla Değiştirildi!'),
        ),
      );
      Navigator.pushReplacementNamed(context, AccountInfoScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    nameSurname = "${userProvider.user.name} ${userProvider.user.surname}";
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        title: const Text("Hesap Bilgileri"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              const CircleAvatar(
                radius: 70,
                backgroundColor: background,
                backgroundImage: AssetImage('assets/Figure.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: tertiaryBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'İsim',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextField(
                            controller: _nameController,
                            placeholder: userProvider.user.name,
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Soyisim',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextField(
                            controller: _surnameController,
                            placeholder: userProvider.user.surname,
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'E-Posta',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextField(
                            controller: _emailController,
                            placeholder: userProvider.user.email,
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Telefon Numarası',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextField(
                            controller: _phoneController,
                            placeholder: userProvider.user.phone,
                            isPassword: false,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        children: <Widget>[
                          CustomLittleButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PasswordChangeScreen.routeName);
                            },
                            text: 'Parola Değiştir',
                            backgroundColor: tertiaryButton,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomLittleButton(
                            onTap: updateUserInfo,
                            text: 'Onayla',
                            backgroundColor: primaryButton,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
        Navigator.pushNamed(context, AccountInfoScreen.routeName);
      },
      child: const Text("Çık"),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Hesap Bilgileri"),
      content: const Text("Düzenlemekten çıkmak istediğinize emin misiniz?"),
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
