import 'package:flutter/material.dart';

Widget appBar(BuildContext context, String title) {
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
  );
}
