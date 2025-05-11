import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Kelas untuk menangani penyimpanan token dan data sensitif
class SecureStorage {
  // Kunci untuk penyimpanan token
  static const String tokenKey = 'auth_token';
  static const String userDataKey = 'user_data';

  // Instance flutter_secure_storage
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Menyimpan token ke secure storage
  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  /// Mendapatkan token dari secure storage
  Future<String?> getToken() async {
    return await _storage.read(key: tokenKey);
  }

  /// Menghapus token dari secure storage (logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: tokenKey);
  }

  /// Menyimpan data user dalam bentuk JSON
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: userDataKey, value: userData);
  }

  /// Mendapatkan data user
  Future<String?> getUserData() async {
    return await _storage.read(key: userDataKey);
  }

  /// Menghapus data user
  Future<void> deleteUserData() async {
    await _storage.delete(key: userDataKey);
  }

  /// Menghapus semua data (clear all)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}