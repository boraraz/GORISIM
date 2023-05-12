// ignore_for_file: must_be_immutable, avoid_print

import 'package:bitirme/screens/no_internet.dart';
import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/screens/translate_vcToGest.dart';
import 'package:bitirme/screens/translate_gestToVc.dart';
import 'package:bitirme/screens/voice_record_info_screen.dart';
import 'package:bitirme/widgets/custom_big_button.dart';
import 'package:bitirme/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String phoneNumber = '112';
bool hasInternet = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      if (!hasInternet) {
        Navigator.pushNamed(context, NoInternet.routeName);
        showErrorBar();
      }
    });
  }

  void showErrorBar() {
    const snackBar = SnackBar(
      content: Text(
        'İnternet bağlantısı yok.',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: primaryButton,
      shape: StadiumBorder(),
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
        title: const Text("GÖRİŞİM"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: primaryColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showAlertDialog();
                    },
                    iconSize: 35.0,
                    color: Colors.red,
                    icon:
                        const Icon(Icons.call), //icon data for elevated button
                  ),
                )),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              CustomBigButton(
                image: 'assets/Translate2.png',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TranslateVcToGest.routeName,
                  );
                },
                text: 'Sesten İşaret Diline',
              ),
              const SizedBox(
                height: 20.0,
              ),
              //İşaret dili -> ses
              CustomBigButton(
                image: 'assets/Translate1.png',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TranslateGestToVc.routeName,
                  );
                },
                text: 'İşaret Dilden Sese',
              ),
              const SizedBox(
                height: 20.0,
              ),
              //Ses Tanıma
              CustomBigButton(
                  image: 'assets/voice_Recog.png',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      VoiceRecordInfoScreen.routeName,
                    );
                  },
                  text: 'Ses Tanıma'),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  emergencyCall(String phoneNumber) async {
    print(phoneNumber);
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  showAlertDialog() {
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
        emergencyCall(phoneNumber);
      },
      child: const Text("Ara"),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      title: const Text("Acil Durum Çağırısı"),
      content: const Text(
          "Vazgeç Tuşuna basmazsanız otomatik acil arama yapılacaktır."),
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

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  String nameSurname = "";
  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      );
  Widget buildHeader(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    nameSurname = "${userProvider.user.name} ${userProvider.user.surname}";
    return (Container(
      color: drawerHeader,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          const LogoutButton(),
          const SizedBox(
            height: 20.0,
          ),
          const CircleAvatar(
            radius: 50,
            backgroundColor: drawerHeader,
            backgroundImage: AssetImage('assets/Figur.png'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            nameSurname,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            userProvider.user.email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
    //
  }

  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 16,
        children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.account_box_rounded),
                title: const Text('Hesap Bilgileri'),
                onTap: () {
                  Navigator.pushNamed(context, '/account_info');
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback_rounded),
                title: const Text('Geri Bildirim'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/feedback',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.apps_rounded),
                title: const Text('Uygulama Hakkında'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/about_app',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Ayarlar'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/settings',
                  );
                },
              ),
            ],
          ),
        ],
      );
}
