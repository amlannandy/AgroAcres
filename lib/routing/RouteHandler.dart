import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screens/InitScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/HomeScreen.dart';
import '../screens/SettingsScreen/SetLanguageScreen.dart';

var initHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return InitScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var setLanguageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SetLanguageScreen();
});
