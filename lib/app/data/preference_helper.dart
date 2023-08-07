import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static late SharedPreferences preferenceHelper;

  static void init() async {
    preferenceHelper = await SharedPreferences.getInstance();
  }

  static Future<void> setValue(
      {required String key, required String value}) async {
    await preferenceHelper.setString(key, value);
  }

  static dynamic getValue({required String key}) {
    return preferenceHelper.getString(key);
  }
}
