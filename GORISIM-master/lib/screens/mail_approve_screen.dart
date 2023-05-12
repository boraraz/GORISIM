// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:async';

import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/screens/login_screen.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MailApproveScreen extends StatefulWidget {
  static const routeName = '/mailApprove';
  const MailApproveScreen({Key? key}) : super(key: key);

  @override
  State<MailApproveScreen> createState() => _MailApproveScreenState();
}

class _MailApproveScreenState extends State<MailApproveScreen> {
  String mail = "";
  var user;
  Timer? timer;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    mail = userProvider.user.email;
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
                  Text(
                    "${user.email} adresine gönderilen mail ile doğrulama yapınız.",
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkmailVerified() async {
    await user.reload();
    if (user.emailVerified) {
      timer!.cancel();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
