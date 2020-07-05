import 'package:flutter/material.dart';

import '../models/Crop.dart';
import '../screens/CalenderScreen/local_widgets/FieldDetails.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              crop.name,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              pocketContainer('District',crop.district),
              pocketContainer('Arrival',crop.arrivalDate),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              pocketData('Min Price', '₹ ' + crop.minPrice),
              pocketData('Modal Price', '₹ ' + crop.modalPrice),
              pocketData('Max Price', '₹ ' + crop.maxPrice),
            ],
          )
        ],
      )
    );
  }

  Widget pocketContainer(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Lato',
              fontSize: 14,
            ),
          ),
          SizedBox(width: 5,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 0.4,
                color: Colors.grey[400],
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontSize: 14,
                ),
              ),
            )
          ),
        ],
      ),
    );
  } 
}