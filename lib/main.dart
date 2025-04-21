import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather/providers/weather_provider.dart';
import 'package:the_weather/providers/theme_provider.dart';
import 'package:the_weather/screens/home_screen.dart';
import 'package:the_weather/utils/constants.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request location permissions on app start
  await Geolocator.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
              ),
              fontFamily: 'Poppins',
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
