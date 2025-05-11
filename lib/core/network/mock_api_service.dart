import 'package:flutter/foundation.dart';

/// Service untuk membuat mock API response selama pengembangan
/// Gunakan class ini saat API backend belum siap atau tersedia
class MockApiService {
  /// Check Email API Mock
  /// Endpoint: /api/check-email
  static Map<String, dynamic> checkEmail(String email) {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Check Email with email: $email");
    }
    
    // Simulate existing user for testing
    final knownEmails = ['test@example.com', 'admin@wanigo.id', 'user@wanigo.id'];
    
    // Check if email exists
    final bool emailExists = knownEmails.contains(email);
    
    if (emailExists) {
      return {
        'status': 'success',
        'message': 'Email terdaftar',
        'data': {
          'email_exists': true,
          'role': 'nasabah'
        }
      };
    } else {
      return {
        'status': 'success',
        'message': 'Email belum terdaftar',
        'data': {
          'email_exists': false
        }
      };
    }
  }
  
  /// Login API Mock
  /// Endpoint: /api/login
  static Map<String, dynamic> login(String email, String password) {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Login with email: $email, password: $password");
    }
    
    // Simulate valid credentials
    if ((email == 'test@example.com' && password == 'password123') ||
        (email == 'admin@wanigo.id' && password == 'admin123') ||
        (email == 'user@wanigo.id' && password == 'user123')) {
      
      return {
        'success': true,
        'data': {
          'user': {
            'id': 1,
            'name': 'User Test',
            'email': email,
            'phone_number': '08123456789',
            'role': 'nasabah',
            'created_at': '2023-05-01T10:00:00.000000Z',
            'updated_at': '2023-05-01T10:00:00.000000Z',
            'nasabah': {
              'id': 1,
              'user_id': 1,
              'jenis_kelamin': null,
              'usia': null,
              'profesi': null,
              'tahu_memilah_sampah': null,
              'motivasi_memilah_sampah': null,
              'nasabah_bank_sampah': null,
              'kode_bank_sampah': null,
              'frekuensi_memilah_sampah': null,
              'jenis_sampah_dikelola': null,
              'profile_completed_at': null,
              'created_at': '2023-05-01T10:00:00.000000Z',
              'updated_at': '2023-05-01T10:00:00.000000Z'
            }
          },
          'access_token': 'mock-access-token-12345',
          'token_type': 'Bearer',
          'profile_status': {
            'is_completed': false,
            'completion_percentage': 0,
            'next_step': 'step1'
          }
        }
      };
    } else {
      return {
        'success': false,
        'data': {
          'message': 'Email atau kata sandi salah'
        }
      };
    }
  }

  /// Register API Mock
  /// Endpoint: /api/register
  static Map<String, dynamic> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Register with email: $email, name: $name");
    }
    
    // Simulate already registered email
    final knownEmails = ['test@example.com', 'admin@wanigo.id', 'user@wanigo.id'];
    if (knownEmails.contains(email)) {
      return {
        'success': false,
        'data': {
          'message': 'Email sudah terdaftar'
        }
      };
    }
    
    // Successful registration
    return {
      'success': true,
      'data': {
        'user': {
          'id': 2,
          'name': name,
          'email': email,
          'phone_number': phone,
          'role': 'nasabah',
          'created_at': '2023-05-01T10:00:00.000000Z',
          'updated_at': '2023-05-01T10:00:00.000000Z',
          'nasabah': {
            'id': 2,
            'user_id': 2,
            'jenis_kelamin': null,
            'usia': null,
            'profesi': null,
            'tahu_memilah_sampah': null,
            'motivasi_memilah_sampah': null,
            'nasabah_bank_sampah': null,
            'kode_bank_sampah': null,
            'frekuensi_memilah_sampah': null,
            'jenis_sampah_dikelola': null,
            'profile_completed_at': null,
            'created_at': '2023-05-01T10:00:00.000000Z',
            'updated_at': '2023-05-01T10:00:00.000000Z'
          }
        },
        'access_token': 'mock-access-token-new-user',
        'token_type': 'Bearer',
        'profile_status': {
          'is_completed': false,
          'completion_percentage': 0,
          'next_step': 'step1'
        }
      }
    };
  }
  
  /// Profile Step 1 API Mock
  /// Endpoint: /api/nasabah/profile/step1
  static Map<String, dynamic> updateProfileStep1({
    required String jenisKelamin,
    required String usia,
    required String profesi,
  }) {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Update Profile Step 1");
      print("DEBUG - jenisKelamin: $jenisKelamin");
      print("DEBUG - usia: $usia");
      print("DEBUG - profesi: $profesi");
    }
    
    return {
      'success': true,
      'data': {
        'nasabah': {
          'id': 1,
          'user_id': 1,
          'jenis_kelamin': jenisKelamin,
          'usia': usia,
          'profesi': profesi,
          'tahu_memilah_sampah': null,
          'motivasi_memilah_sampah': null,
          'nasabah_bank_sampah': null,
          'kode_bank_sampah': null,
          'frekuensi_memilah_sampah': null,
          'jenis_sampah_dikelola': null,
          'profile_completed_at': null,
          'created_at': '2023-05-01T10:00:00.000000Z',
          'updated_at': '2023-05-01T11:00:00.000000Z'
        },
        'profile_status': {
          'is_completed': false,
          'completion_percentage': 33,
          'next_step': 'step2'
        }
      }
    };
  }
  
  /// Profile Step 2 API Mock
  /// Endpoint: /api/nasabah/profile/step2
  static Map<String, dynamic> updateProfileStep2({
    required String tahuMemilahSampah,
    required String motivasiMemilahSampah,
    required String nasabahBankSampah,
    String? kodeBankSampah,
  }) {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Update Profile Step 2");
      print("DEBUG - tahuMemilahSampah: $tahuMemilahSampah");
      print("DEBUG - motivasiMemilahSampah: $motivasiMemilahSampah");
      print("DEBUG - nasabahBankSampah: $nasabahBankSampah");
      print("DEBUG - kodeBankSampah: $kodeBankSampah");
    }
    
    return {
      'success': true,
      'data': {
        'nasabah': {
          'id': 1,
          'user_id': 1,
          'jenis_kelamin': 'Laki-laki', // Assume from step 1
          'usia': '18 hingga 34 tahun', // Assume from step 1
          'profesi': 'Karyawan Swasta', // Assume from step 1
          'tahu_memilah_sampah': tahuMemilahSampah,
          'motivasi_memilah_sampah': motivasiMemilahSampah,
          'nasabah_bank_sampah': nasabahBankSampah,
          'kode_bank_sampah': kodeBankSampah,
          'frekuensi_memilah_sampah': null,
          'jenis_sampah_dikelola': null,
          'profile_completed_at': null,
          'created_at': '2023-05-01T10:00:00.000000Z',
          'updated_at': '2023-05-01T11:15:00.000000Z'
        },
        'profile_status': {
          'is_completed': false,
          'completion_percentage': 66,
          'next_step': 'step3'
        }
      }
    };
  }
  
  /// Profile Step 3 API Mock
  /// Endpoint: /api/nasabah/profile/step3
  static Map<String, dynamic> updateProfileStep3({
    required String frekuensiMemilahSampah,
    required String jenisSampahDikelola,
  }) {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Update Profile Step 3");
      print("DEBUG - frekuensiMemilahSampah: $frekuensiMemilahSampah");
      print("DEBUG - jenisSampahDikelola: $jenisSampahDikelola");
    }
    
    return {
      'success': true,
      'data': {
        'nasabah': {
          'id': 1,
          'user_id': 1,
          'jenis_kelamin': 'Laki-laki', // Assume from step 1
          'usia': '18 hingga 34 tahun', // Assume from step 1
          'profesi': 'Karyawan Swasta', // Assume from step 1
          'tahu_memilah_sampah': 'Sudah tahu', // Assume from step 2
          'motivasi_memilah_sampah': 'Menjaga lingkungan', // Assume from step 2
          'nasabah_bank_sampah': 'Tidak, belum', // Assume from step 2
          'kode_bank_sampah': null,
          'frekuensi_memilah_sampah': frekuensiMemilahSampah,
          'jenis_sampah_dikelola': jenisSampahDikelola,
          'profile_completed_at': '2023-05-01T11:30:00.000000Z',
          'created_at': '2023-05-01T10:00:00.000000Z',
          'updated_at': '2023-05-01T11:30:00.000000Z'
        },
        'profile_status': {
          'is_completed': true,
          'completion_percentage': 100,
          'next_step': null
        }
      }
    };
  }
  
  /// Get Nasabah Profile API Mock
  /// Endpoint: /api/nasabah/profile
  static Map<String, dynamic> getNasabahProfile() {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Get Nasabah Profile");
    }
    
    return {
      'success': true,
      'data': {
        'user': {
          'id': 1,
          'name': 'User Test',
          'email': 'test@example.com',
          'phone_number': '08123456789',
          'role': 'nasabah',
          'created_at': '2023-05-01T10:00:00.000000Z',
          'updated_at': '2023-05-01T10:00:00.000000Z',
          'nasabah': {
            'id': 1,
            'user_id': 1,
            'jenis_kelamin': 'Laki-laki',
            'usia': '18 hingga 34 tahun',
            'profesi': 'Karyawan Swasta',
            'tahu_memilah_sampah': 'Sudah tahu',
            'motivasi_memilah_sampah': 'Menjaga lingkungan',
            'nasabah_bank_sampah': 'Tidak, belum',
            'kode_bank_sampah': null,
            'frekuensi_memilah_sampah': 'Setiap minggu',
            'jenis_sampah_dikelola': 'Plastik',
            'profile_completed_at': '2023-05-01T11:30:00.000000Z',
            'created_at': '2023-05-01T10:00:00.000000Z',
            'updated_at': '2023-05-01T11:30:00.000000Z'
          }
        },
        'profile_status': {
          'is_completed': true,
          'completion_percentage': 100,
          'next_step': null
        }
      }
    };
  }

  /// Check Profile Status API Mock
  /// Endpoint: /api/profile-status
  static Map<String, dynamic> checkProfileStatus() {
    if (kDebugMode) {
      print("DEBUG - MOCK API - Check Profile Status");
    }
    
    return {
      'success': true,
      'data': {
        'profile_status': {
          'is_completed': true,
          'completion_percentage': 100,
          'next_step': null
        }
      }
    };
  }
}