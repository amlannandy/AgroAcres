import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../VideoScreen.dart';
import '../state/WeatherState.dart';

Widget weatherAppBar(BuildContext context, bool isEnglish, WeatherState state) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            state.isLoading ? Icons.hourglass_empty : Icons.location_on,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            state.isLoading ? 'Loading...' : state.currentWeather.areaName,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black.withOpacity(0.8),
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.help,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => VideoScreen(
              isEnglish ? 'Weather' : 'मौसम',
              isEnglish
                  ? TUTORIAL_URL_WEATHER_ENGLISH
                  : TUTORIAL_URL_WEATHER_HINDI,
            ),
          ),
        ),
      )
    ],
  );
}
