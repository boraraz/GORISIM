import 'package:bitirme/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class TranslateButton extends StatelessWidget {
  final String type;
  const TranslateButton({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
        backgroundColor: primaryButton,
        minimumSize: const Size(15, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: () {},
      child: Text(type),
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
        Navigator.pushNamed(context, OnboardingScreen.routeName);
      },
      child: const Text("Çıkış Yap"),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Çıkış Yap"),
      content:
          const Text("Hesabınızdan çıkış yapmak istediğinize emin misiniz?"),
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
