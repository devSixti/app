import 'dart:io';
import 'package:flutter/foundation.dart';

/// Centralized configuration for API settings
class ApiConfig {
  // Get the appropriate base URL based on the platform
  static String get baseUrl {
    if (kIsWeb) {
      // For web, use the same host as the app is served from
      return 'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:1010';
    } else if (Platform.isAndroid) {
      // For Android emulator/device
      return 'http://10.0.2.2:1010';
    } else if (Platform.isIOS) {
      // For iOS simulator/device
      return 'http://localhost:1010';
    } else {
      // For desktop or other platforms
      return 'http://localhost:1010';
    }
  }
  
  // API endpoints - These should be relative to baseUrl
  static const String healthCheck = '/';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Helper method to get full URL
  static String getFullUrl(String endpoint) {
    if (endpoint.startsWith('http')) return endpoint;
    return '$baseUrl${endpoint.startsWith('/') ? endpoint : '/$endpoint'}';
  }
}
