import 'package:bitirme/screens/dev_screen.dart';
import 'package:bitirme/screens/termsOfUseScreen.dart';
import 'package:bitirme/screens/voice_record_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/custom_button.dart';

class Settings extends StatefulWidget {
  static const String routeName = '/settings';
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        title: const Text("Ayarlar"),
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100.0,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, VoiceRecordInfoScreen.routeName);
                },
                text: 'Ses Tanımayı Tekrardan Ayarlama',
                backgroundColor: secondaryButton,
                color: Colors.black,
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, TermsOfUseScreen.routeName);
                },
                text: 'Kullanım Koşulları',
                backgroundColor: secondaryButton,
                color: Colors.black,
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, DevelopersScreen.routeName);
                },
                text: 'Geliştiriciler',
                backgroundColor: secondaryButton,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
