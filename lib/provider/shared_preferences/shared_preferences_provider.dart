import 'package:flutter/material.dart';

import 'package:restaurant_app/service/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier{
  final SharedPreferencesService _sharedPreferencesService;

  SharedPreferencesProvider(this._sharedPreferencesService){
    getBoolTheme();
    getBoolReminder();
  }

  String _message = "";

  String get message => _message;
  bool? _isDarkMode;

  bool get isDarkMode => _isDarkMode ?? false;

  bool? _isReminderOn;

  bool get isReminderOn => _isReminderOn ?? false;

  Future<void> saveSettingsValue(bool val) async {
    try{
      await _sharedPreferencesService.saveTheme(val);
      getBoolTheme();
      _message = "Success to save your data";
    } catch (e){
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  void getBoolTheme(){
    try{
      _isDarkMode = _sharedPreferencesService.getTheme();
      _message = "Success get your data!";
    } catch(e){
      _message = "Failed to get your data";
    }
    notifyListeners();
  }

  Future<void> saveSettingsValueReminder(bool val) async {
    try{
      await _sharedPreferencesService.saveReminder(val);
      getBoolReminder();
      _message = "Success to save your data";
    } catch (e){
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  void getBoolReminder() {
    try {
      _isReminderOn = _sharedPreferencesService.getReminder();
      _message = "Success get your data!";
    } catch (e) {
      _message = "Failed to get your data";
    }
    notifyListeners();
  }

}