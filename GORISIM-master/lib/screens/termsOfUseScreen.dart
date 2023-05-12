// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class TermsOfUseScreen extends StatefulWidget {
  static const String routeName = '/terms_of_use';
  const TermsOfUseScreen({Key? key}) : super(key: key);

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
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
        title: const Text("Kullanım Koşulları"),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: const [
              SizedBox(
                height: 20.0,
              ),
              Text(
                'GÖRİŞİM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "GÖRİŞİM uygulamasını kullanabilmeniz için uygulamanın cihazınızda bulunan mikrofon ve kamernıza erişmesi gerekmektedir. GÖRİŞİM online bir çeviri uygulaması olduğundan, GÖRİŞİM’i kullanabilmeniz için stabil bir internet bağlantısına sahip olmanız gerekmektedir. GÖRİŞİM’in içerisinde bulunan ses tanıma özelliğini kullanmanız sizin uygulamayı kullanımınızı kolaylaştırmakla birlikte opsiyoneldir.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "GÖRİŞİM Ekibi...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
