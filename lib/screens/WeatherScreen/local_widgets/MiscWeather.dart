import 'package:flutter/material.dart';

import '../state/WeatherState.dart';

Widget miscWeather(bool isEnglish, WeatherState state) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.cloud,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isEnglish ? "Cloudiness" : "बादल",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.cloudiness,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.filter_vintage,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isEnglish ? "Humidity" : "नमी",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.humidity,
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
      SizedBox(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.zoom_out_map,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isEnglish ? "Pressure" : "दबाव",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.pressure,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.toys,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isEnglish ? "Wind Speed" : "हवा की गति",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.windSpeed,
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
