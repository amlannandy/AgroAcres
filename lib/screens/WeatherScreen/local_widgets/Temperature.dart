import 'package:flutter/material.dart';

import '../state/WeatherState.dart';

Widget temperature(bool isEnglish, WeatherState state) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.wb_sunny,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              isEnglish ? "Temperature" : "तापमान",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 20,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  isEnglish ? "MAX" : "अधिकतम",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.maxTemp,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 22,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  isEnglish ? "MIN" : "न्यूनतम",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.minTemp,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 22,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ],
  );
}
