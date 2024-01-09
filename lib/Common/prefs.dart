import 'package:shared_preferences/shared_preferences.dart';




class PreferenceManager{
  static late SharedPreferences _preferences;
  static Future<void> initializePrefs() async{
    _preferences = await SharedPreferences.getInstance();
  } 

  static SharedPreferences get instance => _preferences;
}