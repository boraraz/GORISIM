// ignore_for_file: file_names
import 'dart:ffi';

import 'package:bitirme/screens/camera_screen.dart';
import 'package:bitirme/screens/home_screen.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/custom_button.dart';
import 'package:bitirme/widgets/switch_buton_V2G.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslateGestToVc extends StatefulWidget {
  static const String routeName = '/voice2gesture';
  const TranslateGestToVc({
    Key? key,
    this.message,
  }) : super(key: key);
  final String? message;

  @override
  State<TranslateGestToVc> createState() => _TranslateGestToVcState();
}

TextEditingController _textEditingController = TextEditingController();
TextEditingController _LastController = TextEditingController();
String? GPT;
bool _GPTNull = false;

class _TranslateGestToVcState extends State<TranslateGestToVc> {
  @override
  Widget build(BuildContext context) {
    if (widget.message != null) {
      _textEditingController.text = widget.message!;
    }
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
                GPT = null;
                _textEditingController.clear();
                _LastController.clear();
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
                    const SwitchButtonV2G(),
                    const SizedBox(
                      width: 100.0,
                    ),
                    Container(
                      width: 130,
                      height: 70,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/Translate1.png'),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CameraScreen.routeName,
                    );
                  },
                  text: 'Kamerayı Aç',
                  backgroundColor: primaryButton,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: _textEditingController,
                  style: const TextStyle(
                    color: secondaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Çevirilen yazı burada gösterilecek...',
                    hintMaxLines: 100,
                    filled: true,
                    fillColor: bigButtonBackground,
                    border: OutlineInputBorder(
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
                    send(widget.message!);
                  },
                  text: 'Cümleyi Düzelt',
                  backgroundColor: primaryButton,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _isNull() {
    if (_textEditingController.text == '') {
      return false;
    } else {
      return true;
    }
  }

  Future payload(Uri url, String fileContent) async {
    final codec = const Latin9Codec(allowInvalid: false);
    var payload = http.MultipartRequest('POST', url);

    var data = {'my_data': fileContent};
    payload.fields.addAll(data);

    var response = await http.Response.fromStream(await payload.send());
    _textEditingController.text = codec.decode(response.bodyBytes);
  }

  Future send(String message) async {
    final url = Uri.parse(
        'https://2c55-46-221-20-22.ngrok-free.app/Bitirme/chatGPT.php');
    payload(url, message);
  }
}
