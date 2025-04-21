import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_weather/models/weather_model.dart';
import 'package:the_weather/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  final String apiKey = '98f4e7372e63527c7e7b064099c2947f';

  Future<LocationModel> getCurrentLocation() async {
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permissions
      throw Exception('Location permissions are permanently denied. Please enable them in app settings.');
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get place name from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String locationName = 'Unknown Location';
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      locationName = place.locality ?? place.subAdministrativeArea ?? 'Unknown Location';
    }

    return LocationModel(
      name: locationName,
      lat: position.latitude,
      lon: position.longitude,
    );
  }

  Future<WeatherModel> getWeatherData(double lat, double lon) async {
    final url = '${ApiConstants.baseUrl}/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key or unauthorized access. Please check your API key or subscription plan.');
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  // Get Current Weather data
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    final url = '${ApiConstants.baseUrl}/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load current weather data: ${response.statusCode}');
    }
  }

  // Get Forecast data
  Future<WeatherModel> getForecast(double lat, double lon) async {
    final url = '${ApiConstants.baseUrl}/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load forecast data: ${response.statusCode}');
    }
  }

  // Get Air Pollution data
  Future<Map<String, dynamic>> getAirPollution(double lat, double lon) async {
    final url = '${ApiConstants.baseUrl}/air_pollution?lat=$lat&lon=$lon&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air pollution data: ${response.statusCode}');
    }
  }
}