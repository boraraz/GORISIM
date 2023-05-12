import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/screens/home_screen.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class VoiceRecordBeginScreen extends StatefulWidget {
  static const String routeName = '/voice_begin';
  const VoiceRecordBeginScreen({Key? key}) : super(key: key);

  @override
  State<VoiceRecordBeginScreen> createState() => _VoiceRecordBeginScreenState();
}

String userID = '';
var index = 0;
var isLast = false;

class _VoiceRecordBeginScreenState extends State<VoiceRecordBeginScreen> {
  @override
  void initState() {
    super.initState();

    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  static const IconData mic = IconData(0xe3e1, fontFamily: 'MaterialIcons');
  final List<String> sentences = [
    'Hayır, gelmeyeceğim',
    'Kütüphanede kitap okuyorum.',
    'Derslerime çalışıyorum',
    'Bir makale yazmak için araştırma yapıyorum',
    'Ödev yapacağım için arkadaşlarımla buluştum',
  ];

  final recorder = SoundRecorder();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userID = userProvider.user.uid;
    final isRecording = recorder.isRecording;
    final buttonColor = isRecording ? Colors.red : primaryButton;
    final text = isRecording ? 'Kaydı Durdur' : 'Kaydet';
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.close_sharp,
                size: 50,
              ),
              onPressed: () {
                showAlertDialog(context);
              },
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Text(
                'Cümle ${index + 1}/5',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: tertiaryBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        textWidthBasis: TextWidthBasis.longestLine,
                        textAlign: TextAlign.center,
                        sentences[index],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      AvatarGlow(
                        glowColor: primaryButton,
                        endRadius: 100.0,
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        child: Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 75.0,
                            child:
                                const Icon(mic, size: 80, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final isRecording = await recorder.toggleRecording();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          backgroundColor: buttonColor,
                          minimumSize: const Size(150, 60),
                        ),
                        child: Text(text,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              isLast
                  ? CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                        showActionSnackBar(context);
                        setState(() {
                          index = 0;
                          isLast = false;
                        });
                      },
                      text: 'Ses Kaydını Bitir',
                      backgroundColor: primaryButton,
                      color: Colors.white,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void showActionSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Ses Tanıma Başarıyla Tamamlandı',
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

  showAlertDialog(BuildContext context) {
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
        setState(() {
          isLast = false;
          index = 0;
        });
        Navigator.pushNamed(context, HomeScreen.routeName);
      },
      child: const Text("Çık"),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Ses Tanıma"),
      content: const Text(
          "Ses Tanımadan çıkmak istediğinize emin misiniz? Değişiklikler kaybolacaktır."),
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

Future payload(Uri url, List<int> fileContent, String userID) async {
  var payload = http.MultipartRequest('POST', url)
    ..files.add(http.MultipartFile.fromBytes(
      'file',
      fileContent,
      filename: filePath,
      contentType: MediaType('video', 'wav'),
    ));
  var data = {'my_data': userID};
  payload.fields.addAll(data);

  var response = await http.Response.fromStream(await payload.send());

  print(response.body);
}

Directory? appDocDirectory;
String? filePath;

class SoundRecorder {
  FlutterSoundRecorder? audioRecorder;
  bool isRecorderInitialized = false;

  bool get isRecording => audioRecorder!.isRecording;

  Future init() async {
    audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await audioRecorder!.openRecorder();
    isRecorderInitialized = true;
  }

  void dispose() {
    audioRecorder!.closeRecorder();
    audioRecorder = null;
    isRecorderInitialized = false;
  }

  Future record() async {
    appDocDirectory = await getApplicationDocumentsDirectory();
    filePath = '${appDocDirectory!.path}/${userID}_${index + 1}.wav';
    if (!isRecorderInitialized) return;
    await audioRecorder!
        .startRecorder(toFile: filePath!, codec: Codec.pcm16WAV);
  }

  Future stop() async {
    if (!isRecorderInitialized) return;
    await audioRecorder!.stopRecorder();
    final file = File(filePath!);
    final bytes = await file.readAsBytes();

    final url = Uri.parse(
        'https://e8ec-81-214-28-33.ngrok-free.app/Bitirme/ProfileGenerator.php');
    payload(url, bytes, userID);
    print(userID);
    print(filePath);
  }

  Future toggleRecording() async {
    if (audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
      if (index < 4) {
        index++;
      } else {
        isLast = true;
      }
    }
  }
}
