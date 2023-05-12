import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/resources/auth.methods.dart';
import 'package:bitirme/screens/account_edit.dart';
import 'package:bitirme/screens/camera_screen.dart';
import 'package:bitirme/screens/dev_screen.dart';
import 'package:bitirme/screens/forgot_pass_screen.dart';
import 'package:bitirme/screens/mail_approve_forgot_screen.dart';
import 'package:bitirme/screens/mail_approve_screen.dart';
import 'package:bitirme/screens/no_internet.dart';
import 'package:bitirme/screens/password_change_forgot_screen.dart';
import 'package:bitirme/screens/password_change_screen.dart';
import 'package:bitirme/screens/termsOfUseScreen.dart';
import 'package:bitirme/screens/about_app.dart';
import 'package:bitirme/screens/account_info.dart';
import 'package:bitirme/screens/home_screen.dart';
import 'package:bitirme/screens/login_screen.dart';
import 'package:bitirme/screens/onboarding_screen.dart';
import 'package:bitirme/screens/settings.dart';
import 'package:bitirme/screens/sign_up_screen.dart';
import 'package:bitirme/screens/feedback_screen.dart';
import 'package:bitirme/screens/translate_vcToGest.dart';
import 'package:bitirme/screens/translate_gestToVc.dart';
import 'package:bitirme/screens/video_player.dart';
import 'package:bitirme/screens/voice_record_begin_screen.dart';
import 'package:bitirme/screens/voice_record_info_screen.dart';
import 'package:bitirme/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:bitirme/models/user.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GÖRİŞİM',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: background,
          appBarTheme: AppBarTheme.of(context).copyWith(
              backgroundColor: secondaryBackground,
              elevation: 0,
              titleTextStyle: const TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.w700),
              iconTheme: const IconThemeData(color: textColor, size: 40)),
        ),
        routes: {
          NoInternet.routeName: (context) => const NoInternet(),
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          AccountInfoScreen.routeName: (context) => const AccountInfoScreen(),
          FeedbackScreen.routeName: (context) => const FeedbackScreen(),
          AboutApp.routeName: (context) => const AboutApp(),
          Settings.routeName: (context) => const Settings(),
          TermsOfUseScreen.routeName: (context) => const TermsOfUseScreen(),
          DevelopersScreen.routeName: (context) => const DevelopersScreen(),
          // ignore: equal_keys_in_map
          AccountEditScreen.routeName: (context) => const AccountEditScreen(),
          PasswordChangeScreen.routeName: (context) =>
              const PasswordChangeScreen(),
          MailApproveScreen.routeName: (context) => const MailApproveScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),
          // ignore: equal_keys_in_map
          MailApproveForgotScreen.routeName: (context) =>
              const MailApproveForgotScreen(),
          // ignore: equal_keys_in_map
          PasswordChangeForgotScreen.routeName: (context) =>
              const PasswordChangeForgotScreen(),
          VoiceRecordInfoScreen.routeName: (context) =>
              const VoiceRecordInfoScreen(),
          VoiceRecordBeginScreen.routeName: (context) =>
              const VoiceRecordBeginScreen(),

          // ignore: equal_keys_in_map
          TranslateVcToGest.routeName: (context) => const TranslateVcToGest(),
          TranslateGestToVc.routeName: (context) => const TranslateGestToVc(),
          CameraScreen.routeName: (context) => CameraScreen(),
          VideoPlayerr.routeName: (context) => VideoPlayerr(),
        },
        home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(FirebaseAuth.instance.currentUser != null
                  ? FirebaseAuth.instance.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false).setUser(
                model.User.fromMap(value),
              );
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const NoInternet();
          },
        ),
      ),
    );
  }
}
