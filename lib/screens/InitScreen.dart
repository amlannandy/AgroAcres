import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../services/LocalizationProvider.dart';
import '../services/UserDatabaseService.dart';

class InitScreen extends StatefulWidget {
  static const routeName = '/init';

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  bool _redirect;
  String _redirectURL;

  Future<bool> _checkAuthStatus(BuildContext ctx) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String lang = sharedPreferences.getString('lang');
      if (lang == null) {
        _redirect = true;
        _redirectURL = "/setlanguage";
        return true;
      }
      await Provider.of<LocalizationProvider>(context, listen: false)
          .switchLanguage(lang == 'en');
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      if (currentUser == null) {
        _redirect = true;
        _redirectURL = "/login";
        return true;
      }
      UserDatabaseService databaseService = UserDatabaseService();
      User user = await databaseService.getUser(currentUser.uid);
      if (user == null) {
        _redirect = true;
        _redirectURL = "/userinfo";
        return true;
      }
      _redirectURL = "/navbarcontroller";
      _redirect = true;
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Image.asset(TO ADD LOGO HERE),
              FutureBuilder<bool>(
                future: _checkAuthStatus(context),
                builder: (BuildContext c, AsyncSnapshot<bool> snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData && snapshot.data) {
                    print("InitState Returned: ${snapshot.data}");
                    new Future.delayed(Duration(milliseconds: 500), () {
                      print("Redirect: $_redirect $_redirectURL  |");
                      if (_redirect)
                        Navigator.of(context)
                            .pushReplacementNamed(_redirectURL);
                    });
                    return Container();
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    Text(
                      "Authentication Error",
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    );
                  }
                  return Column(
                    children: children,
                  );
                },
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]),
              ),
            ],
          )),
    );
  }
}
