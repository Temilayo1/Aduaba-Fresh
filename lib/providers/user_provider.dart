import 'package:aduaba_app/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();

  User get user => _user;

  void setUser(User user) async {
    await Future.delayed(Duration(seconds: 5));
    _user = user;
    notifyListeners();
  }
}
