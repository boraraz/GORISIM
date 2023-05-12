// ignore_for_file: prefer_const_declarations, file_names

import 'dart:io';
import 'package:bitirme/providers/user_provider.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/video_player_widget.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:http/http.dart' as http;
import 'package:bitirme/screens/home_screen.dart';
import 'package:bitirme/screens/video_player.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/switch_button_G2V.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:video_player/video_player.dart';

String userID = '';
MultipartFile? multipartFile;
String hintMsg = "Ses kaydınız burada yazı olarak belirecek";
String responseMessage = '';

bool isInitialized = false;

var splittedResponse = List<String>.empty(growable: true);
var urlList = List<String>.empty(growable: true);

class TranslateVcToGest extends StatefulWidget {
  static const String routeName = '/gesture2voice';
  const TranslateVcToGest({Key? key}) : super(key: key);

  @override
  State<TranslateVcToGest> createState() => _TranslateVcToGestState();
}

TextEditingController _textEditingController = TextEditingController();

class _TranslateVcToGestState extends State<TranslateVcToGest> {
  @override
  void initState() {
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();
    super.dispose();
  }

  //audio recorder
  final recorder = SoundRecorder();
  final player = SoundPlayer();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userID = userProvider.user.uid;
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'Kaydı Durdur' : 'Kaydet';
    final primary = isRecording ? Colors.red : primaryButton;
    final onPrimary = isRecording ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        title: const Text("Çevirici"),
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
                hintMsg = "Ses kaydınız burada yazı olarak belirecek";
                Navigator.pushNamed(
                  context,
                  HomeScreen.routeName,
                );
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Wrap(
                  children: <Widget>[
                    const SwitchButtonG2V(),
                    const SizedBox(
                      width: 100.0,
                    ),
                    Container(
                      width: 130,
                      height: 70,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/Translate2.png'),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: primary,
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                        style: IconButton.styleFrom(),
                        icon: Icon(icon),
                        color: onPrimary,
                        iconSize: 60,
                        onPressed: () async {
                          // ignore: unused_local_variable
                          final isRecording = await recorder.toggleRecording();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    TextField(
                      controller: _textEditingController,
                      style: const TextStyle(
                        color: secondaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: hintMsg,
                        hintMaxLines: 300,
                        filled: true,
                        fillColor: bigButtonBackground,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      readOnly: true,
                      autofocus: false,
                      minLines: 5,
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => VideoPlayerr(
                                    urlList: urlList,
                                  )),
                            ),
                          );
                        },
                        text: "Oynat",
                        backgroundColor: primaryButton,
                        color: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future payload(Uri url, List<int> fileContent, String userID) async {
  final codec = const Latin9Codec(allowInvalid: false);
  var payload = http.MultipartRequest('POST', url)
    ..files.add(http.MultipartFile.fromBytes(
      'file',
      fileContent,
      filename: filePath,
      contentType: MediaType('video', 'wav'),
    ));
  var data = {'my_data': 'ege'};
  payload.fields.addAll(data);

  var response = await http.Response.fromStream(await payload.send());
  print(codec.decode(response.bodyBytes));

  responseMessage = codec.decode(response.bodyBytes);
  _textEditingController.text = responseMessage;
  createList();
}

createList() {
  // append to a list the urls
  splitResponse();
  urlList.clear();
  for (var i = 0; i < splittedResponse.length; i++) {
    urlList.add(
        'https://2c55-46-221-20-22.ngrok-free.app/Bitirme/Videos/${splittedResponse.elementAt(i)}.mp4');
  }
  print(urlList);
}

splitResponse() {
  splittedResponse.clear();
  splittedResponse = responseMessage.split(" ");
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
    filePath = '${appDocDirectory!.path}/$userID.wav';
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
        'https://2c55-46-221-20-22.ngrok-free.app/Bitirme/Videos.php');
    payload(url, bytes, userID);
  }

  Future toggleRecording() async {
    if (audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}

class SoundPlayer {
  FlutterSoundPlayer? audioPlayer;
  bool isPlayerInitialized = false;

  bool get isPlaying => audioPlayer!.isPlaying;

  Future init() async {
    audioPlayer = FlutterSoundPlayer();

    await audioPlayer!.openPlayer();
    isPlayerInitialized = true;
  }

  void dispose() {
    audioPlayer!.closePlayer();
    audioPlayer = null;
    isPlayerInitialized = false;
  }

  Future play(VoidCallback whenFinished) async {
    if (!isPlayerInitialized) return;
    await audioPlayer!.startPlayer(
      fromURI: filePath,
      whenFinished: whenFinished,
      codec: Codec.aacADTS,
    );
  }

  Future stop() async {
    if (!isPlayerInitialized) return;
    await audioPlayer!.stopPlayer();
  }

  Future togglePlayer({required VoidCallback whenFinished}) async {
    if (audioPlayer!.isStopped) {
      await play(whenFinished);
    } else {
      await stop();
    }
  }
}
