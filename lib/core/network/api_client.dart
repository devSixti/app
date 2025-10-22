import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../config/api_config.dart';

class ApiClient {
  final http.Client _client;
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final Duration timeout;

  ApiClient({
    http.Client? client,
    String? customBaseUrl,
    Map<String, String>? headers,
    this.timeout = ApiConfig.connectTimeout,
  })  : _client = client ?? http.Client(),
        baseUrl = customBaseUrl ?? ApiConfig.baseUrl,
        defaultHeaders = {
          ...ApiConfig.headers,
          ...?headers,
        };

  Future<Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .get(uri, headers: {...defaultHeaders, ...?headers})
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      throw const SocketException('No Internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection timeout');
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .post(
            uri,
            headers: {...defaultHeaders, ...?headers},
            body: body is Map || body is List ? jsonEncode(body) : body,
          )
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      throw const SocketException('No Internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection timeout');
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // Add other HTTP methods (put, patch, delete) as needed

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final url = '${endpoint.startsWith('http') ? '' : baseUrl}${endpoint.startsWith('/') ? endpoint : '/$endpoint'}';
    final uri = Uri.parse(url);
    
    if (queryParameters != null) {
      return uri.replace(
        queryParameters: queryParameters
            .map((key, value) => MapEntry(key, value?.toString() ?? '')),
      );
    }
    return uri;
  }

  Response _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw NotFoundException('The requested data was not found');
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with the server with status code: ${response.statusCode}',
        );
    }
  }

  void close() {
    _client.close();
  }
}

// Custom Exceptions
class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException(this.message, {this.prefix});

  @override
  String toString() => prefix != null ? '$prefix: $message' : message;
}

class FetchDataException extends AppException {
  FetchDataException(super.message)
      : super(prefix: 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException(super.message) : super(prefix: 'Invalid Request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message) : super(prefix: 'Unauthorized');
}

class NotFoundException extends AppException {
  NotFoundException(super.message) : super(prefix: 'Not Found');
}
