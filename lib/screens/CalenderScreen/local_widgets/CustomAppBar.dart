import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../VideoScreen.dart';

Widget customAppBar(BuildContext context, String title, bool isEnglish) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 22,
          color: Colors.black.withOpacity(0.8),
          fontWeight: FontWeight.bold),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black.withOpacity(0.8),
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.help,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => VideoScreen(
              title,
              isEnglish
                  ? TUTORIAL_URL_CALENDER_ENGLISH
                  : TUTORIAL_URL_CALENDER_HINDI,
            ),
          ),
        ),
      )
    ],
  );
}
