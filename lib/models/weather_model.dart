class WeatherModel {
  final CurrentWeather current;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  WeatherModel({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      current: CurrentWeather.fromJson(json['current']),
      hourly: List<HourlyForecast>.from(
        json['hourly'].map((x) => HourlyForecast.fromJson(x)),
      ).take(24).toList(),
      daily: List<DailyForecast>.from(
        json['daily'].map((x) => DailyForecast.fromJson(x)),
      ),
    );
  }
}

class CurrentWeather {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double uvi;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final List<WeatherInfo> weather;

  CurrentWeather({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.uvi,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      uvi: json['uvi'].toDouble(),
      visibility: json['visibility'],
      windSpeed: json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'],
      weather: List<WeatherInfo>.from(
        json['weather'].map((x) => WeatherInfo.fromJson(x)),
      ),
    );
  }
}

class HourlyForecast {
  final int dt;
  final double temp;
  final List<WeatherInfo> weather;

  HourlyForecast({
    required this.dt,
    required this.temp,
    required this.weather,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      dt: json['dt'],
      temp: json['temp'].toDouble(),
      weather: List<WeatherInfo>.from(
        json['weather'].map((x) => WeatherInfo.fromJson(x)),
      ),
    );
  }
}

class DailyForecast {
  final int dt;
  final Temp temp;
  final List<WeatherInfo> weather;

  DailyForecast({
    required this.dt,
    required this.temp,
    required this.weather,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      dt: json['dt'],
      temp: Temp.fromJson(json['temp']),
      weather: List<WeatherInfo>.from(
        json['weather'].map((x) => WeatherInfo.fromJson(x)),
      ),
    );
  }
}

class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day'].toDouble(),
      min: json['min'].toDouble(),
      max: json['max'].toDouble(),
      night: json['night'].toDouble(),
      eve: json['eve'].toDouble(),
      morn: json['morn'].toDouble(),
    );
  }
}

class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class LocationModel {
  final String name;
  final double lat;
  final double lon;

  LocationModel({
    required this.name,
    required this.lat,
    required this.lon,
  });
}
