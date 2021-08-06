import 'package:flutter/material.dart';

import '../state/WeatherState.dart';

Widget forecasts(bool isEnglish, BuildContext context, WeatherState state) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 140,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(
      color: Colors.black.withOpacity(0.8),
      width: 0.4,
    )),
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.wb_sunny,
                      color: Colors.black.withOpacity(0.8),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    isEnglish ? "Temperature" : "तापमान",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    isEnglish ? "Cloudiness" : "बादल",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "1",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNTemperature(1),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNCloudiness(1),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "2",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNTemperature(2),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNCloudiness(2),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "3",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNTemperature(3),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNCloudiness(3),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "4",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNTemperature(4),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNCloudiness(4),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "5",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNTemperature(5),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.getDayNCloudiness(5),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
