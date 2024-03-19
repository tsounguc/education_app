import 'package:education_app/features/auth/data/models/user_models.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
