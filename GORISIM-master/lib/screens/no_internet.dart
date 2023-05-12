// ignore_for_file: use_build_context_synchronously

import 'package:bitirme/screens/onboarding_screen.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class NoInternet extends StatefulWidget {
  static const String routeName = '/no_internet';
  const NoInternet({
    Key? key,
  }) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

bool hasInternet = false;

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: const [BoxShadow(blurRadius: 40.0)],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "GÖRİŞİM",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Cebinizdeki Çeviri Uygulamanız",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "GÖRİŞİM'e hoşgeldiniz.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  textWidthBasis: TextWidthBasis.longestLine,
                  textAlign: TextAlign.center,
                  "Devam etmek için aşağıdaki butonu kullanarak internet bağlantınızı konrtol ediniz.*",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 250,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: primaryButton,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  child: const Text('İnternet Bağlantısını Dene'),
                  onPressed: () async {
                    hasInternet =
                        await InternetConnectionChecker().hasConnection;

                    final color = hasInternet ? primaryButton : tertiaryButton;
                    final text = hasInternet
                        ? 'İnternete bağlandı'
                        : 'İnternet bağlantısı yok. Lütfen İnternete bağlanın';

                    if (hasInternet == true) {
                      Navigator.pushNamed(context, OnboardingScreen.routeName);
                    }

                    showSimpleNotification(
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      background: color,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "*İnternet bağlantısı olmadan uygulama kullanılamaz.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
