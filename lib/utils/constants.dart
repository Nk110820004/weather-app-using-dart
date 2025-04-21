import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String iconUrl = 'https://openweathermap.org/img/wn';
}

class AppColors {
  static const Color primaryColor = Color(0xFF5D50FE);
  static const Color secondaryColor = Color(0xFF90CAF9);
  static const Color accentColor = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color darkBackgroundColor = Color(0xFF303030);
}

class WeatherUtils {
  static String getFormattedDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEEE, d MMMM').format(date);
  }

  static String getHourFromTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('h a').format(date);
  }

  static String getDayFromTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEE').format(date);
  }

  static String getWeatherIcon(String iconCode) {
    return '${ApiConstants.iconUrl}/$iconCode@2x.png';
  }

  static String getWeatherAnimation(String iconCode) {
    if (iconCode.contains('01')) {
      return 'clear';
    } else if (iconCode.contains('02') || iconCode.contains('03') || iconCode.contains('04')) {
      return 'cloudy';
    } else if (iconCode.contains('09') || iconCode.contains('10')) {
      return 'rainy';
    } else if (iconCode.contains('11')) {
      return 'thunder';
    } else if (iconCode.contains('13')) {
      return 'snow';
    } else if (iconCode.contains('50')) {
      return 'mist';
    } else {
      return 'clear';
    }
  }
}
