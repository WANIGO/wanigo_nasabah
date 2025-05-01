import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/core/network/http_client.dart';

/// Service untuk menangani request API
class ApiService {
  // HTTP Client untuk melakukan request
  final HttpClient _httpClient = HttpClient();
  
  /// Check Email API
  /// Endpoint: /api/check-email
  Future<Map<String, dynamic>> checkEmail(String email) async {
    try {
      // Debugging
      if (kDebugMode) {
        print("DEBUG - Check Email Request with email: $email");
      }

      // Prepare request data
      final data = {'email': email};
      
      // Use HTTP Client to make request
      final response = await _httpClient.post('/check-email', data);
      
      // Debugging
      if (kDebugMode) {
        print("DEBUG - Check Email Response: $response");
      }
      
      // Return formatted response
      return response;
    } catch (e) {
      // Handle exceptions and return formatted error
      if (kDebugMode) {
        print("DEBUG - Check Email API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Login API
  /// Endpoint: /api/login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Login Request with email: $email");
      }
      
      // Prepare request data
      final data = {
        'email': email,
        'password': password,
      };
      
      // Execute request
      final response = await _httpClient.post('/login', data);
      
      if (kDebugMode) {
        print("DEBUG - Login Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Login API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Register API
  /// Endpoint: /api/register
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Register Request with email: $email");
      }
      
      // Prepare request data
      final data = {
        'name': name,
        'email': email,
        'phone_number': phone,
        'password': password,
        'password_confirmation': password,
        'role': 'nasabah', // Default role
      };
      
      // Execute request
      final response = await _httpClient.post('/register', data);
      
      if (kDebugMode) {
        print("DEBUG - Register Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Register API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Forgot Password API
  /// Endpoint: /api/forgot-password
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Forgot Password Request with email: $email");
      }
      
      // Prepare request data
      final data = {
        'email': email,
      };
      
      // Execute request
      final response = await _httpClient.post('/forgot-password', data);
      
      if (kDebugMode) {
        print("DEBUG - Forgot Password Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Forgot Password API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Reset Password API
  /// Endpoint: /api/reset-password
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String email,
    required String password,
  }) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Reset Password Request with email: $email");
      }
      
      // Prepare request data
      final data = {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': password,
      };
      
      // Execute request
      final response = await _httpClient.post('/reset-password', data);
      
      if (kDebugMode) {
        print("DEBUG - Reset Password Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Reset Password API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Logout API
  /// Endpoint: /api/logout
  Future<Map<String, dynamic>> logout() async {
    try {
      if (kDebugMode) {
        print("DEBUG - Logout Request");
      }
      
      // Execute request
      final response = await _httpClient.post('/logout', {});
      
      if (kDebugMode) {
        print("DEBUG - Logout Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Logout API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Check Profile Status API
  /// Endpoint: /api/profile-status
  Future<Map<String, dynamic>> checkProfileStatus() async {
    try {
      if (kDebugMode) {
        print("DEBUG - Check Profile Status Request");
      }
      
      // Execute request
      final response = await _httpClient.get('/profile-status');
      
      if (kDebugMode) {
        print("DEBUG - Check Profile Status Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Check Profile Status API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Get Nasabah Profile API
  /// Endpoint: /api/nasabah/profile
  Future<Map<String, dynamic>> getNasabahProfile() async {
    try {
      if (kDebugMode) {
        print("DEBUG - Get Nasabah Profile Request");
      }
      
      // Execute request
      final response = await _httpClient.get('/nasabah/profile');
      
      if (kDebugMode) {
        print("DEBUG - Get Nasabah Profile Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Get Nasabah Profile API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
  
  /// Update Profile Step 1 API 
  /// Endpoint: /api/nasabah/profile/step1
  Future<Map<String, dynamic>> updateProfileStep1({
    required String jenisKelamin,
    required String usia,
    required String profesi,
  }) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 1 Request with data: jenis_kelamin=$jenisKelamin, usia=$usia, profesi=$profesi");
      }
      
      // Prepare request data
      final data = {
        'jenis_kelamin': jenisKelamin,
        'usia': usia,
        'profesi': profesi,
      };
      
      // Execute request
      final response = await _httpClient.post('/nasabah/profile/step1', data);
      
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 1 Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 1 API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }

  /// Update Profile Step 2 API 
  /// Endpoint: /api/nasabah/profile/step2
  Future<Map<String, dynamic>> updateProfileStep2({
    required String tahuMemilahSampah,
    required String motivasiMemilahSampah,
    required String nasabahBankSampah,
    String? kodeBankSampah,
  }) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 2 Request");
      }
      
      // Prepare request data
      final data = {
        'tahu_memilah_sampah': tahuMemilahSampah,
        'motivasi_memilah_sampah': motivasiMemilahSampah,
        'nasabah_bank_sampah': nasabahBankSampah,
      };
      
      // Add kode_bank_sampah only if provided
      if (kodeBankSampah != null && kodeBankSampah.isNotEmpty) {
        data['kode_bank_sampah'] = kodeBankSampah;
      }
      
      // Execute request
      final response = await _httpClient.post('/nasabah/profile/step2', data);
      
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 2 Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 2 API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }

  /// Update Profile Step 3 API 
  /// Endpoint: /api/nasabah/profile/step3
  Future<Map<String, dynamic>> updateProfileStep3({
    required String frekuensiMemilahSampah,
    required String jenisSampahDikelola,
  }) async {
    try {
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 3 Request");
      }
      
      // Prepare request data
      final data = {
        'frekuensi_memilah_sampah': frekuensiMemilahSampah,
        'jenis_sampah_dikelola': jenisSampahDikelola,
      };
      
      // Execute request
      final response = await _httpClient.post('/nasabah/profile/step3', data);
      
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 3 Response: $response");
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Update Profile Step 3 API Exception: $e");
      }
      
      return {
        'success': false,
        'statusMessage': e.toString(),
      };
    }
  }
}