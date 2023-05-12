import 'package:bitirme/screens/account_edit.dart';
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/colors.dart';

class EditButton extends StatelessWidget {
  const EditButton({Key? key}) : super(key: key);

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
            AccountEditScreen.routeName,
          );
        },
        iconSize: 30.0,
        color: Colors.white,
        icon: const Icon(Icons.edit_rounded), //icon data for elevated button
      ),
    );
  }
}
