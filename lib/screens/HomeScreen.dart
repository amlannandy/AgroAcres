import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/ProductsListScreen.dart';
import '../services/LocalizationProvider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).accentColor,
      ])),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            width: MediaQuery.of(context).size.width,
            child: header(context, isEnglish),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: ProductsListScreen(false)),
        ],
      ),
    );
  }

  Widget header(BuildContext context, bool isEnglish) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(isEnglish ? 'Shop' : 'दुकान',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
            fontSize: 20,
          )),
    );
  }
}
