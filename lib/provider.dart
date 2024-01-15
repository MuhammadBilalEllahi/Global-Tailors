import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  String? userType;
  double? height;
  XFile? pickedFiles;
  String? downloadUrls;
  String? authId;
  String? tailorIDs;
  String? bookIDs;

  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }

  void setHeight(double value) {
    height = value;
    notifyListeners();
  }

  void imgPath(XFile pickedFile) {
    pickedFiles = pickedFile;
    notifyListeners();
  }

  void downloadUrlString(String downloadURL) {
    downloadUrls = downloadURL;
    notifyListeners();
  }

  void setAuthId(String uid) {
    authId = uid;
    notifyListeners();
  }

  void tailorID(String s) {
    tailorIDs = s;
    // notifyListeners();
  }

  void setBookID(String bookId) {
    bookIDs = bookId;
    notifyListeners();
  }
}
