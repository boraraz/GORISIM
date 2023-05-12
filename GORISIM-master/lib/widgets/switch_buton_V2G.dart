// ignore_for_file: file_names

import 'package:bitirme/screens/translate_vcToGest.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class SwitchButtonV2G extends StatelessWidget {
  const SwitchButtonV2G({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: primaryButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            TranslateVcToGest.routeName,
          );
        },
        iconSize: 50.0,
        color: Colors.white,
        icon:
            const Icon(Icons.autorenew_rounded), //icon data for elevated button
      ),
    );
  }
}
