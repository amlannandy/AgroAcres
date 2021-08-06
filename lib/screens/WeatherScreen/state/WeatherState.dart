import 'package:weather/weather_library.dart';

class WeatherState {
  String error;
  bool isLoading = false;
  Weather currentWeather;
  List<Weather> forecasts;

  WeatherState.onRequest() {
    this.isLoading = true;
  }

  WeatherState.onSuccess(this.currentWeather, this.forecasts) {
    this.isLoading = false;
  }

  WeatherState.onError(this.error) {
    this.isLoading = false;
  }

  String get location => currentWeather.areaName.toString();

  String get maxTemp =>
      currentWeather.tempMax.celsius.toStringAsFixed(1) + "°C";

  String get minTemp =>
      currentWeather.tempMin.celsius.toStringAsFixed(1) + "°C";

  String get humidity => currentWeather.humidity.toString() + "%";

  String get cloudiness => currentWeather.cloudiness.toString() + "%";

  String get pressure => currentWeather.pressure.toString() + " Pa";

  String get windSpeed => currentWeather.windSpeed.toString() + " m/s";

  String getDayNTemperature(int n) =>
      forecasts[n].temperature.celsius.toStringAsFixed(1) + "°C";

  String getDayNCloudiness(int n) => forecasts[n].cloudiness.toString() + "%";
}
