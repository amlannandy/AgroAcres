import 'package:flutter/material.dart';

import '../../../models/CropField.dart';
import '../screens/MyCropFieldScreen.dart';
import '../../../services/CropFieldProvider.dart';

Widget fieldCard(BuildContext context, CropField cropField, bool isEnglish) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MyCropFieldScreen(cropField.id))),
    child: Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[350],
              blurRadius: 20.0,
              spreadRadius: 0.02,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 0.4,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(cropField.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                cropField.crop,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              pocketData(isEnglish ? 'Sowing Date' : 'बुवाई की तारीख',
                  cropField.startTime),
              pocketData(
                  isEnglish ? 'Harvest Date' : 'फसल की तारीख',
                  CropFieldProvider.getFormattedDatePlusDays(
                      cropField.startDate, cropField.harvestTime)),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget pocketData(String upperText, String lowerText) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
