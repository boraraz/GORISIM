import 'package:bitirme/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    uid: '',
    name: '',
    surname: '',
    email: '',
    phone: '',
    password: '',
  );

  User get user => _user;

  setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
