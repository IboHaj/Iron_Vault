import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;

  static Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }
}