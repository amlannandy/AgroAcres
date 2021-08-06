import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './state/WeatherBloc.dart';
import './state/WeatherState.dart';
import './local_widgets/Temperature.dart';
import './local_widgets/Forecasts.dart';
import './local_widgets/MiscWeather.dart';
import '../../widgets/LoadingSpinner.dart';
import './local_widgets/WeatherAppBar.dart';
import '../../services/LocalizationProvider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return StreamBuilder<WeatherState>(
      initialData: WeatherState.onRequest(),
      stream: Provider.of<WeatherBloc>(context).state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return Scaffold(
          appBar: weatherAppBar(context, isEnglish, state),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: state.isLoading
                  ? Center(child: loadingSpinner())
                  : Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            isEnglish
                                ? "5 Day Forecast"
                                : "5 दिन का पूर्वानुमान",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        forecasts(isEnglish, context, state),
                        SizedBox(height: 20),
                        temperature(isEnglish, state),
                        SizedBox(height: 40),
                        miscWeather(isEnglish, state),
                        SizedBox(height: 20),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
