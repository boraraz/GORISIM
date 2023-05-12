import 'package:bitirme/screens/mail_approve_forgot_screen.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _mailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: const Text("GÖRİŞİM"),
        titleTextStyle: const TextStyle(
          color: primaryColor,
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
                  "Şifremi Unuttum",
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
                    // Email
                    const Text(
                      'E-postanızı giriniz*',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: _mailController,
                      placeholder: 'E-posta...',
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      '*Girilen e-mail veya telefonunuza gelecek link ile şifrenizi sıfırlayabilirsiniz.',
                      style: TextStyle(
                        color: Color.fromRGBO(165, 165, 165, 1),
                      ),
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
                    Navigator.pushNamed(
                      context,
                      MailApproveForgotScreen.routeName,
                    );
                  },
                  text: 'Şifremi Sıfırla',
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
