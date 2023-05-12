import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/resources/auth.methods.dart';
import 'package:bitirme/screens/home_screen.dart';
import 'package:bitirme/screens/onboarding_screen.dart';
import 'package:bitirme/screens/voice_record_info_screen.dart';
import 'package:bitirme/widgets/custom_little_button.dart';
import 'package:bitirme/widgets/custom_show_field.dart';
import 'package:bitirme/widgets/edit_button.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:provider/provider.dart';

class AccountInfoScreen extends StatefulWidget {
  static const String routeName = '/account_info';
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final AuthMethods _authMethods = AuthMethods();
  String nameSurname = '';

  deleteUser() async {
    bool res = await _authMethods.deleteUser(context);
    if (res) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
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
        title: const Text("Hesap Bilgieri"),
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.navigate_before,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            );
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.topRight,
                child: const EditButton(),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const CircleAvatar(
                radius: 70,
                backgroundColor: background,
                backgroundImage: AssetImage('assets/Figure.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                nameSurname,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
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
                            'E-Posta',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomShowField(placeholder: userProvider.user.email),
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
                          CustomShowField(
                            placeholder: userProvider.user.phone,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        children: <Widget>[
                          CustomLittleButton(
                            onTap: () => showAlertDialog(context),
                            text: 'Hesabı Sil',
                            backgroundColor: primaryButton,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomLittleButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, VoiceRecordInfoScreen.routeName);
                            },
                            text: 'Ses Ayarlama',
                            backgroundColor: tertiaryButton,
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
      onPressed: deleteUser,
      child: const Text("Hesabı Sil"),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Hesap Silme"),
      content: const Text(
          "Hesabınızı silmeyi onaylıyor musunuz? Bu işlem geri alınamaz."),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cancelButton,
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
