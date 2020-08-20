import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './VideoScreen.dart';
import '../screens/ProductsListScreen.dart';
import '../services/LocalizationProvider.dart';

const HOME_ENGLISH_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FEcommerce%20Final-5.m4v?alt=media&token=1980311d-1b10-477a-bc3f-df39672cd43c';
const HOME_HINDI_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FEcommerce%20Final-5.m4v?alt=media&token=1980311d-1b10-477a-bc3f-df39672cd43c';

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
              height: MediaQuery.of(context).size.height * 0.79,
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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => VideoScreen(isEnglish ? 'Shop' : 'दुकान',
                    isEnglish ? HOME_ENGLISH_URL : HOME_HINDI_URL))),
          )
        ],
      ),
    );
  }
}
