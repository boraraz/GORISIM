import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class AboutApp extends StatefulWidget {
  static const String routeName = '/about_app';
  const AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
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
        title: const Text("Uygulama Hakkında"),
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
                'GÖRİŞİM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "GÖRİŞİM işitme engelli bireyler ile işaret dilini öğrenmemize gerek kalmadan iletişime geçmemize olanak tanıyan mobil bir uygulamadır. GÖRİŞİM hem ses işleme hem de görüntü işleme teknolojilerini kullanmaktadır. Bu sayede sadece sesinizi kullanarak, söylediğiniz cümleyi işaret diline ve de kameranızı kullanarak yaptığınız işaret dilini Türkçe’ye çevirebilmektesiniz.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(
                "assets/Head.png",
                width: 290,
                height: 290,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
