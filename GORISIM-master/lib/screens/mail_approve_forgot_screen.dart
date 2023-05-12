import 'package:bitirme/screens/password_change_forgot_screen.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class MailApproveForgotScreen extends StatefulWidget {
  static const routeName = '/mailApprove_forgot';
  const MailApproveForgotScreen({Key? key}) : super(key: key);

  @override
  State<MailApproveForgotScreen> createState() =>
      _MailApproveForgotScreenState();
}

class _MailApproveForgotScreenState extends State<MailApproveForgotScreen> {
  final TextEditingController _codeController = TextEditingController();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  "E-posta Doğrulama",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: primaryColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Email
                  const Text(
                    "E-postanıza gelen doğrulama kodunu giriniz.",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: _codeController,
                    placeholder: '6 haneli doğrulama kodu...',
                    isPassword: false,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Doğrulama kodu gelmedi mi? Tekrar gönder',
                      style: TextStyle(
                        color: forgotPass,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PasswordChangeForgotScreen.routeName,
                    );
                  },
                  text: 'Doğrula',
                  backgroundColor: primaryButton,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
