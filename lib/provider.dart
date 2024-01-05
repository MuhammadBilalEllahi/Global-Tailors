import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? userType;

  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }
}
