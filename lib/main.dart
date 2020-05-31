import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/InitScreen.dart';
import './screens/LoginScreen.dart';
import './screens/ChatbotScreen.dart';
import './screens/UserInfoScreen.dart';
import './screens/NavBarController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          accentColor: Colors.green[600],
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            bodyText2: TextStyle(
              fontFamily: 'Varela',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          '/init' : (ctx) => InitScreen(),
          '/login' : (ctx) => LoginScreen(),
          '/userinfo' : (ctx) => UserInfoScreen(),
          '/navbarcontroller' : (ctx) => NavBarController(),
          '/chatbot' : (ctx) => ChatbotScreen(),
        },
        initialRoute: '/init',
      ),
    );
  }
}