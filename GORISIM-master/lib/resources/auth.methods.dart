// ignore_for_file: use_build_context_synchronously

import 'package:bitirme/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bitirme/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:bitirme/utilities/utils.dart';
import 'package:provider/provider.dart';

class AuthMethods {
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      return snap.data();
    }
    return null;
  }

  Future<bool> signUpUser(
    BuildContext context,
    String name,
    String surname,
    String email,
    String phone,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        model.User user = model.User(
          uid: cred.user!.uid,
          name: name.trim(),
          surname: surname.trim(),
          email: email.trim(),
          phone: phone.trim(),
          password: password.trim(),
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> updatePass(BuildContext context, String password) async {
    bool res = false;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(password);
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> updateUserInfo(BuildContext context, String name, String surname,
      String phone, String email) async {
    bool res = false;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _userRef.doc(user.uid).update({
          'name': name,
          'surname': surname,
          'phone': phone,
        });
        Provider.of<UserProvider>(context, listen: false).setUser(
          model.User.fromMap(
            await getCurrentUser(user.uid) ?? {},
          ),
        );
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> deleteUser(BuildContext context) async {
    bool res = false;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _userRef.doc(user.uid).delete();
        await user.delete();
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(
          model.User.fromMap(
            await getCurrentUser(cred.user!.uid) ?? {},
          ),
        );
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }
}
