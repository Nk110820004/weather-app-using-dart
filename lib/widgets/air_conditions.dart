import 'package:flutter/material.dart';
import 'package:the_weather/models/weather_model.dart';

class AirConditionsWidget extends StatelessWidget {
  final CurrentWeather currentWeather;

  const AirConditionsWidget({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildAirConditionItem(
                  context,
                  'Humidity',
                  '${currentWeather.humidity}%',
                  Icons.water_drop_outlined,
                ),
              ),
              Expanded(
                child: _buildAirConditionItem(
                  context,
                  'Wind',
                  '${currentWeather.windSpeed.toStringAsFixed(1)} m/s',
                  Icons.air_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildAirConditionItem(
                  context,
                  'Visibility',
                  '${(currentWeather.visibility / 1000).toStringAsFixed(1)} km',
                  Icons.visibility_outlined,
                ),
              ),
              Expanded(
                child: _buildAirConditionItem(
                  context,
                  'UV Index',
                  _getUVIndexText(currentWeather.uvi),
                  Icons.wb_sunny_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAirConditionItem(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _getUVIndexText(double uvi) {
    if (uvi <= 2) {
      return 'Low';
    } else if (uvi <= 5) {
      return 'Moderate';
    } else if (uvi <= 7) {
      return 'High';
    } else if (uvi <= 10) {
      return 'Very High';
    } else {
      return 'Extreme';
    }
  }
}
