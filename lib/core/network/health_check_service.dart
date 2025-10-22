import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class HealthCheckService {
  const HealthCheckService();

  /// Checks if the backend is reachable
  /// Returns true if the backend is reachable, false otherwise
  Future<bool> checkBackendConnection() async {
    try {
      developer.log(
        'Checking backend connection to: ${ApiConfig.baseUrl}${ApiConfig.healthCheck}',
      );

      // Use a direct http client for the health check to avoid circular dependencies
      final client = http.Client();
      final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.healthCheck}');

      try {
        final response = await client
            .get(
              url,
              headers: {
                'Cache-Control': 'no-cache',
                'Accept': 'application/json',
              },
            )
            .timeout(const Duration(seconds: 5));

        developer.log(
          'Health check response: ${response.statusCode} - ${response.body}',
        );

        // Consider the backend healthy if we get any 2xx response
        return response.statusCode >= 200 && response.statusCode < 300;
      } catch (e) {
        developer.log('Health check error: $e');
        return false;
      } finally {
        client.close();
      }
    } catch (e) {
      developer.log('Unexpected error in health check: $e');
      return false;
    }
  }
}
