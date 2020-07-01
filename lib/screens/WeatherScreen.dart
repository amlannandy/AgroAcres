import 'package:AgroAcres/widgets/LoadingSpinner.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../services/WeatherProvider.dart';

class WeatherScreen extends StatefulWidget {

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  var _isLoading = false;
  var _isInit = true;

  Position currentPosition;

  Future getUserLocation() async {
    currentPosition = await Geolocator().getCurrentPosition();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<WeatherProvider>(context).weather == null) {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        getUserLocation().then((value) {
          Provider.of<WeatherProvider>(context, listen: false).getFiveDayForecast(currentPosition).then((_) {
            Provider.of<WeatherProvider>(context, listen: false).getForecast(currentPosition).then((_) {
              setState(() {
                _isLoading = false;
              });
            });
          });
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Weather'),
      body: _isLoading ? loadingSpinner() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "5 Day Forecast",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              forecastRow(),
              SizedBox(height: 20),
              temperatureRow(),
              SizedBox(height: 40),
              miscRow(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: locationRow(),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget locationRow() {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            _isLoading ? Icons.hourglass_empty : Icons.location_on,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            _isLoading ? 'Loading...' : Provider.of<WeatherProvider>(context).getLocation(),
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget temperatureRow() {
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
                "Temperature",
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
                    "MAX",
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
                    Provider.of<WeatherProvider>(context).getMaxTemp(),
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
                    "MIN",
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
                    Provider.of<WeatherProvider>(context).getMinTemp(),
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

  Widget miscRow() {
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
                        "Cloudiness",
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
                    Provider.of<WeatherProvider>(context).getCloudiness(),
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
                        "Humidity",
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
                    Provider.of<WeatherProvider>(context).getHumidity(),
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
                        "Pressure",
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
                    Provider.of<WeatherProvider>(context).getPressure(),
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
                        "Wind Speed",
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
                    Provider.of<WeatherProvider>(context).getWindSpeed(),
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

  Widget forecastRow() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 140,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.8),
          width: 0.4,
        )
      ),
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
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Temperature",
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
                      "Cloudiness",
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
                      Provider.of<WeatherProvider>(context).getDayOneTemp(),
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
                      Provider.of<WeatherProvider>(context).getDayOneCloudiness(),
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
                      Provider.of<WeatherProvider>(context).getDayTwoTemp(),
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
                      Provider.of<WeatherProvider>(context).getDayTwoCloudiness(),
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
                      Provider.of<WeatherProvider>(context).getDayThreeTemp(),
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
                      Provider.of<WeatherProvider>(context).getDayThreeCloudiness(),
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
                      Provider.of<WeatherProvider>(context).getDayFourTemp(),
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
                      Provider.of<WeatherProvider>(context).getDayFourCloudiness(),
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
                      Provider.of<WeatherProvider>(context).getDayFiveTemp(),
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
                      Provider.of<WeatherProvider>(context).getDayFiveCloudiness(),
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
}