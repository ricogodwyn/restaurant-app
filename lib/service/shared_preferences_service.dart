import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  static const String _keyTheme = "KEY_THEME";
  static const String _keyReminder = "KEY_REMINDER";

  Future<void> saveTheme(bool val) async {
    try {
      await _sharedPreferences.setBool(_keyTheme, val);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  bool? getTheme()  {
    return _sharedPreferences.getBool(_keyTheme);
  }

  Future<void> saveReminder(bool val) async {
    try {
      await _sharedPreferences.setBool(_keyReminder, val);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  bool? getReminder()  {
    return _sharedPreferences.getBool(_keyReminder);
  }
}