import 'package:bitirme/screens/voice_record_begin_screen.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class VoiceRecordInfoScreen extends StatefulWidget {
  static const String routeName = '/voice_info';
  const VoiceRecordInfoScreen({Key? key}) : super(key: key);

  @override
  State<VoiceRecordInfoScreen> createState() => _VoiceRecordInfoScreenState();
}

class _VoiceRecordInfoScreenState extends State<VoiceRecordInfoScreen> {
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
        title: const Text("Ses Tanıma Ayarlama"),
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
                'Bilgilendirme',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: const [
                    Text(
                      'Ses Tanıma özelliği sesli bir ortamda bulunmanıza rağmen sizin sesinizi diğer sesler arasından seçip uygulamayı rahatça kullanabilmenizi sağlar.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ses Tanıma özelliğini ayarlamadan önce sessiz bir ortamda bulunduğunuzdan emin olunuz.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ses Tanıma özelliğini ayarlarken cihazınızın mikrofonuna yakın olduğunuzdan emin olunuz.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ses Tanıma ayarı sırasında okumanız istenilen cümleleri anlaşılabilir şekilde okuduğunuzdan emin olunuz.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    VoiceRecordBeginScreen.routeName,
                  );
                },
                text: 'Ses Tanımayı Başlat',
                backgroundColor: primaryButton,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
