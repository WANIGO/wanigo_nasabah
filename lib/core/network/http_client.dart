import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// HTTP Client untuk menangani request API dengan token auth
class HttpClient {
  // Base URL API - Gunakan URL production yang sudah di-deploy
  final String baseUrl = 'https://api.wanigo.my.id'; // Base URL API production
  
  // Secure storage untuk menyimpan token
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Key untuk token
  static const String _tokenKey = 'auth_token';
  
  /// GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      // Ambil token jika ada
      final token = await getToken();
      
      // Prepare headers
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      
      // Add token to headers if exists
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      
      // Prepare URL
      final url = Uri.parse('$baseUrl$endpoint');
      
      if (kDebugMode) {
        print('DEBUG - GET Request: $url');
        print('DEBUG - Headers: $headers');
      }
      
      // Execute request
      final response = await http.get(
        url,
        headers: headers,
      ).timeout(const Duration(seconds: 30)); // Timeout 30 seconds
      
      // Log response
      if (kDebugMode) {
        print('DEBUG - Response Status Code: ${response.statusCode}');
        print('DEBUG - Response Body: ${response.body}');
      }
      
      // Parse response
      final parsedResponse = jsonDecode(response.body);
      
      // Check response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': parsedResponse,
        };
      } else {
        return {
          'success': false,
          'statusCode': response.statusCode,
          'data': parsedResponse,
        };
      }
    } on SocketException {
      // No internet connection
      if (kDebugMode) {
        print('DEBUG - No internet connection');
      }
      return {
        'success': false,
        'statusMessage': 'Tidak ada koneksi internet',
      };
    } on FormatException {
      // Invalid response format
      if (kDebugMode) {
        print('DEBUG - Invalid response format');
      }
      return {
        'success': false,
        'statusMessage': 'Format respons tidak valid',
      };
    } on http.ClientException catch (e) {
      // HTTP client exception
      if (kDebugMode) {
        print('DEBUG - Client exception: ${e.message}');
      }
      return {
        'success': false,
        'statusMessage': 'Client exception: ${e.message}',
      };
    } catch (e) {
      // Other exceptions
      if (kDebugMode) {
        print('DEBUG - Exception: ${e.toString()}');
      }
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// POST request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      // Ambil token jika ada
      final token = await getToken();
      
      // Prepare headers
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      
      // Add token to headers if exists
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      
      // Prepare URL and request body
      final url = Uri.parse('$baseUrl$endpoint');
      final body = jsonEncode(data);
      
      if (kDebugMode) {
        print('DEBUG - POST Request: $url');
        print('DEBUG - Headers: $headers');
        print('DEBUG - Body: $body');
      }
      
      // Execute request
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 30)); // Timeout 30 seconds
      
      // Log response
      if (kDebugMode) {
        print('DEBUG - Response Status Code: ${response.statusCode}');
        print('DEBUG - Response Body: ${response.body}');
      }
      
      // Parse response
      final parsedResponse = jsonDecode(response.body);
      
      // Check response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': parsedResponse,
        };
      } else {
        return {
          'success': false,
          'statusCode': response.statusCode,
          'data': parsedResponse,
        };
      }
    } on SocketException {
      // No internet connection
      if (kDebugMode) {
        print('DEBUG - No internet connection');
      }
      return {
        'success': false,
        'statusMessage': 'Tidak ada koneksi internet',
      };
    } on FormatException {
      // Invalid response format
      if (kDebugMode) {
        print('DEBUG - Invalid response format');
      }
      return {
        'success': false,
        'statusMessage': 'Format respons tidak valid',
      };
    } on http.ClientException catch (e) {
      // HTTP client exception
      if (kDebugMode) {
        print('DEBUG - Client exception: ${e.message}');
      }
      return {
        'success': false,
        'statusMessage': 'Client exception: ${e.message}',
      };
    } catch (e) {
      // Other exceptions
      if (kDebugMode) {
        print('DEBUG - Exception: ${e.toString()}');
      }
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Save token to secure storage
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    if (kDebugMode) {
      print('DEBUG - Token saved: $token');
    }
  }
  
  /// Get token from secure storage
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (kDebugMode) {
      print('DEBUG - Token retrieved: ${token != null ? 'Yes' : 'No'}');
    }
    return token;
  }
  
  /// Delete token from secure storage
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
    if (kDebugMode) {
      print('DEBUG - Token deleted');
    }
  }
}