import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather_library.dart';

import './WeatherState.dart';
import '../../../config.dart';

class WeatherBloc {
  WeatherStation weatherStation = new WeatherStation(WEATHER_API_KEY);

  WeatherBloc() {
    _getWeatherForecast();
  }

  StreamController<WeatherState> _stateController =
      StreamController<WeatherState>.broadcast();

  _getWeatherForecast() async {
    try {
      final position = await Geolocator().getCurrentPosition();
      final currentWeather = await weatherStation.currentWeather(
        position.latitude,
        position.longitude,
      );
      final forecasts = await weatherStation.fiveDayForecast(
        position.latitude,
        position.longitude,
      );
      _setState(WeatherState.onSuccess(currentWeather, forecasts));
    } catch (e) {
      _setState(WeatherState.onError('Error fetching weather'));
    }
  }

  _setState(WeatherState state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void refresh() {
    _getWeatherForecast();
  }

  void dispose() {
    _stateController.close();
  }

  Stream<WeatherState> get state => _stateController.stream;
}
