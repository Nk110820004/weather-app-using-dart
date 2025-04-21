import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_model.dart';
import 'package:the_weather/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weatherData;
  LocationModel? _location;
  bool _isLoading = false;
  String? _error;

  WeatherModel? get weatherData => _weatherData;
  LocationModel? get location => _location;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadWeatherData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get current location
      final location = await _weatherService.getCurrentLocation();
      _location = location;

      // Get weather data based on location
      final weatherData = await _weatherService.getWeatherData(
        location.lat,
        location.lon,
      );

      _weatherData = weatherData;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
