import 'package:flutter/material.dart';

import '../../VideoScreen.dart';

const CALENDER_ENGLISH_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FCropcalendar%20Final-2.m4v?alt=media&token=d911d7ea-63e2-459f-9b51-bdaebdcb593b';
const CALENDER_HINDI_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FCropcalendar%20Final-2.m4v?alt=media&token=d911d7ea-63e2-459f-9b51-bdaebdcb593b';

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
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => VideoScreen(title,
                  isEnglish ? CALENDER_ENGLISH_URL : CALENDER_HINDI_URL))),
        )
      ]);
}
