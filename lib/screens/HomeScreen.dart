import 'package:flutter/material.dart';

import '../screens/ProductsListScreen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ]
        )
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            width: MediaQuery.of(context).size.width,
            child: header(context),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: ProductsListScreen(false)
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        'Shop',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
          fontSize: 20,
        )
      ),
    );
  }
}