import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config.dart';
import '../VideoScreen.dart';
import 'local_widgets/ProductsList.dart';
import '../../services/LocalizationProvider.dart';

class ProductsScreen extends StatelessWidget {
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
            height: MediaQuery.of(context).size.height * 0.79,
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: ProductsList(),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context, bool isEnglish) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(isEnglish ? 'Shop' : 'दुकान',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                fontSize: isEnglish ? 20 : 24,
              )),
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => VideoScreen(
                  isEnglish ? 'Shop' : 'दुकान',
                  isEnglish
                      ? TUTORIAL_URL_MANDI_ENGLISH
                      : TUTORIAL_URL_HOME_HINDI,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
