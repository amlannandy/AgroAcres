import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/Crop.dart';

class CropCard extends StatelessWidget {

  final Crop crop;

  CropCard(this.crop);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                pocketContainer(Icons.restaurant, crop.name),
                SizedBox(height: 12.5),
                pocketContainer(FontAwesomeIcons.rupeeSign, crop.maxPrice + ' / kg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pocketContainer(IconData iconData, String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.4,
          color: Colors.grey[400],
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Lato',
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}