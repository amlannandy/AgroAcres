import 'package:flutter/material.dart';
import '../../../widgets/PrimaryButton.dart';

Widget emptyBanner(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/empty.png'),
        SizedBox(height: 40),
        Text(
          'Looks like you haven\'t added your Crop Field yet',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            color: Colors.green[800].withOpacity(0.7),
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Do it now to get a complete timeline on how to nurture your crop',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
            color: Colors.green[800].withOpacity(0.7),
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        PrimaryButton(
          text: 'START NOW',
          press: () => Navigator.of(context).pushNamed('/addcropfield'),
          color: Theme.of(context).primaryColor,
        ),
      ],
    ),
  );
}