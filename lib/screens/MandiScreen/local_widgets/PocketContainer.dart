import 'package:flutter/material.dart';

Widget pocketContainer(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Lato',
            fontSize: 10,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 0.4,
              color: Colors.grey[400],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
