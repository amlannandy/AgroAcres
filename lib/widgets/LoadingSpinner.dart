import 'package:flutter/material.dart';

Widget loadingSpinner() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]),
    ),
  );
}