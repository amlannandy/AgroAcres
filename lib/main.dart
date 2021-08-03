import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/InitScreen.dart';
import './screens/LoginScreen.dart';
import './screens/WeatherScreen.dart';
import './screens/UserInfoScreen.dart';
import './screens/NavBarController.dart';
import './screens/MyProductsScreen.dart';
import './services/WeatherProvider.dart';
import './screens/AddProductScreen.dart';
import './services/LocalizationProvider.dart';
import './screens/CalenderScreen/screens/FieldScreen.dart';
import './screens/SettingsScreen/screens/SettingsScreen.dart';
import './screens/CalenderScreen/screens/CalenderScreen.dart';
import './screens/SettingsScreen/screens/SetLanguageScreen.dart';
import './screens/CalenderScreen/screens/AddCropFieldScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
        ChangeNotifierProvider.value(value: LocalizationProvider()),
        ChangeNotifierProvider.value(value: WeatherProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.lightGreen,
          accentColor: Colors.green[600],
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              fontFamily: 'Varela',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          '/init': (ctx) => InitScreen(),
          '/login': (ctx) => LoginScreen(),
          '/userinfo': (ctx) => UserInfoScreen(),
          '/navbarcontroller': (ctx) => NavBarController(),
          '/myproducts': (ctx) => MyProductsScreen(),
          '/addproduct': (ctx) => AddProductScreen(),
          '/weather': (ctx) => WeatherScreen(),
          '/field': (ctx) => FieldScreen(),
          '/calender': (ctx) => CalenderScreen(),
          '/addcropfield': (ctx) => AddCropFieldScreen(),
          '/settings': (ctx) => SettingsScreen(),
          '/setlanguage': (ctx) => SetLanguageScreen(),
        },
        initialRoute: '/init',
      ),
    );
  }
}
