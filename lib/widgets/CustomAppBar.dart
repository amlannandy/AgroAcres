import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    ),
    elevation: 0,
    flexibleSpace: appBarDeco(context),
  );
}

Widget appBarDeco(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ]
      )
    ),
  );
}