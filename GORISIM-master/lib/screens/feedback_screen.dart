import 'dart:convert';

import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/widgets/custom_big_textfield.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/custom_show_field.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  static const String routeName = '/feedback';
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  String nameSurname = '';
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
        title: const Text("Geri Bildirim"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Görüşlerinizi bildirin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Görüşlerinizi bildirerek uygulamamızı geliştirmemize yardımcı olabilirsiniz.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('İsim',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  CustomShowField(
                    placeholder: nameSurname,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Geri Bildirim',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  CustomBigTextField(
                      controller: _feedbackController,
                      placeholder: 'Geri bildiriminizi giriniz...'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                    onTap: () {
                      sendEmail(
                        name: nameSurname,
                        email: 'teststaj1@gmail.com',
                        message: _feedbackController.text,
                      );
                      _feedbackController.clear();
                      showActionSnackBar(context);
                    },
                    text: 'Gönder',
                    backgroundColor: primaryButton,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    const serviceId = 'service_vceqk6e';
    const templateId = 'template_03gbx5f';
    const userId = '61IVTfl_6FSBWDKtR';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
        },
      }),
    );
    print(response.body);
  }

  void showActionSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Geri bildiriminiz için teşekkürler!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: secondaryBackground,
      shape: StadiumBorder(),
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
