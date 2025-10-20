import 'package:flutter/cupertino.dart';

class ResultState extends ChangeNotifier{
  String _value = "";

  String get value => _value;

  set value(String value) {
    _value = value;
    notifyListeners();
  }
}