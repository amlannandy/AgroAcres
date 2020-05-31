import 'package:flutter/material.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            child: Image.network(
              crop.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  crop.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Lato',
                    fontSize: 22,
                  ),
                ),
                Text(
                  '₹ ' + crop.price.toStringAsFixed(0),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}