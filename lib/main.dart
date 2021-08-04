import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'routing/Routes.dart';
import 'routing/Application.dart';
import './services/LocalizationProvider.dart';

void main() => runApp(AgroAcresApp());

class AgroAcresApp extends StatelessWidget {
  AgroAcresApp() {
    final router = FluroRouter();
    Routes.configureRouter(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
        ChangeNotifierProvider.value(value: LocalizationProvider()),
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
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
