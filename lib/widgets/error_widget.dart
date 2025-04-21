import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const WeatherErrorWidget({
    Key? key,
    required this.error,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLocationError = error.toLowerCase().contains('location');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isLocationError ? Icons.location_off : Icons.cloud_off,
              size: 80,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              isLocationError ? 'Location Access Required' : 'Oops! Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isLocationError
                  ? 'Please enable location services to get weather data for your current location.'
                  : error,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            if (isLocationError) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
