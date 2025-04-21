import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_model.dart';
import 'package:the_weather/utils/constants.dart';

class HourlyForecastWidget extends StatelessWidget {
  final List<HourlyForecast> hourlyForecast;

  const HourlyForecastWidget({
    Key? key,
    required this.hourlyForecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: hourlyForecast.length,
        itemBuilder: (context, index) {
          final hourData = hourlyForecast[index];
          final weatherInfo = hourData.weather.first;
          final isNow = index == 0;

          return Container(
            width: 80,
            margin: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == hourlyForecast.length - 1 ? 16 : 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isNow ? 'Now' : WeatherUtils.getHourFromTimestamp(hourData.dt),
                  style: TextStyle(
                    fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
                    color: isNow ? theme.colorScheme.primary : null,
                  ),
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: Image.network(
                          WeatherUtils.getWeatherIcon(weatherInfo.icon),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  '${hourData.temp.round()}°',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isNow ? theme.colorScheme.primary : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
