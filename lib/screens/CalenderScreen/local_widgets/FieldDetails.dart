import 'package:flutter/material.dart';

Widget fieldDetails(
    {String cropName,
    String imageUrl,
    String startDate,
    String endDate,
    bool isEnglish}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              cropName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            pocketData(isEnglish ? 'Sowing Date' : 'बुवाई की तारीख', startDate),
            pocketData(isEnglish ? 'Harvest Date' : 'फसल की तारीख', endDate),
          ],
        ),
      ],
    ),
  );
}

Widget pocketData(String upperText, String lowerText) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        Text(
          upperText,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'Varela',
          ),
        ),
        Text(
          lowerText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Varela',
          ),
        ),
      ],
    ),
  );
}
