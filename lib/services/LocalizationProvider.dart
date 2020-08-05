import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  String _currentLanguage = '';

  Future<String> checkForLanguagePreset() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString('lang');
    return language;
  }

  Future switchLanguage(bool isEnglish) async {
    String choosenLanguage = '';
    if (isEnglish)
      choosenLanguage = 'en';
    else
      choosenLanguage = 'hn';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('lang', choosenLanguage);
    _currentLanguage = choosenLanguage;
    notifyListeners();
  }

  String getCurrentLanguage() {
    return _currentLanguage;
  }
}
