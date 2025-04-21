import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather/providers/weather_provider.dart';
import 'package:the_weather/providers/theme_provider.dart';
import 'package:the_weather/widgets/current_weather.dart';
import 'package:the_weather/widgets/hourly_forecast.dart';
import 'package:the_weather/widgets/daily_forecast.dart';
import 'package:the_weather/widgets/air_conditions.dart';
import 'package:the_weather/widgets/loading_widget.dart';
import 'package:the_weather/widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load weather data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).loadWeatherData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshWeatherData() async {
    await Provider.of<WeatherProvider>(context, listen: false).loadWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const LoadingWidget();
          }

          if (weatherProvider.error != null) {
            return WeatherErrorWidget(
              error: weatherProvider.error!,
              onRetry: _refreshWeatherData,
            );
          }

          if (weatherProvider.weatherData == null) {
            return const Center(
              child: Text('No weather data available'),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshWeatherData,
            child: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    floating: true,
                    pinned: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      IconButton(
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ],
                    title: Row(
                      children: [
                        const Icon(Icons.location_on, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          weatherProvider.location?.name ?? 'Loading location...',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current Weather Widget
                          CurrentWeatherWidget(
                            weatherData: weatherProvider.weatherData!.current,
                          ),

                          const SizedBox(height: 24),

                          // Hourly Forecast
                          const Text(
                            'Today\'s Forecast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          HourlyForecastWidget(
                            hourlyForecast: weatherProvider.weatherData!.hourly,
                          ),

                          const SizedBox(height: 24),

                          // Air Conditions
                          const Text(
                            'Air Conditions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          AirConditionsWidget(
                            currentWeather: weatherProvider.weatherData!.current,
                          ),

                          const SizedBox(height: 24),

                          // 7-Day Forecast
                          const Text(
                            '7-Day Forecast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          DailyForecastWidget(
                            dailyForecast: weatherProvider.weatherData!.daily,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
