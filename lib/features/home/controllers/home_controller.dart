import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/data/models/auth_models.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

class HomeController extends GetxController {
  // Repository
  final AuthRepository _authRepository = AuthRepository();
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // User data
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  
  // User points
  int get userPoints => 0; // Untuk sementara hardcoded, nanti bisa diambil dari API
  
  // Tabungan data
  final RxDouble saldoTabungan = 24000.00.obs;
  final RxDouble beratSampah = 12.0.obs;
  
  // Flag untuk menandai controller di-dispose
  bool _isDisposed = false;
  
  // User name
  String get userName => user.value?.name ?? 'Nasabah';
  
  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }
  
  @override
  void onClose() {
    _isDisposed = true;
    super.onClose();
  }
  
  /// Load initial data for home screen
  Future<void> _loadInitialData() async {
    isLoading.value = true;
    
    try {
      // Ambil data user dari repository
      final userData = await _authRepository.getUser();
      if (userData != null) {
        user.value = userData;
      }
      
      // Get profile data if needed
      try {
        final nasabahProfile = await _authRepository.getNasabahProfile();
        if (!_isDisposed) {
          user.value = nasabahProfile;
        }
      } catch (e) {
        if (kDebugMode) {
          print("DEBUG - Error getting nasabah profile: $e");
        }
      }
      
      // Here you can add API calls to get other home data like:
      // - Tabungan data
      // - Jadwal data
      // - etc.
      
    } catch (e) {
      if (_isDisposed) return;
      
      errorMessage.value = e.toString();
      if (kDebugMode) {
        print("DEBUG - Home load data error: ${errorMessage.value}");
      }
    } finally {
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }
  
  /// Navigate to profile page
  void goToProfile() {
    if (_isDisposed) return;
    Get.toNamed(Routes.profile);
  }
  
  /// Navigate to bank sampah page
  void goToBankSampah() {
    if (_isDisposed) return;
    
    // Belum diimplementasi
    Get.snackbar(
      'Info',
      'Fitur Bank Sampah sedang dalam pengembangan',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// Navigate to setoran sampah page
  void goToSetoranSampah() {
    if (_isDisposed) return;
    
    // Belum diimplementasi
    Get.snackbar(
      'Info',
      'Fitur Setoran Sampah sedang dalam pengembangan',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// Navigate to jadwal page
  void goToJadwal() {
    if (_isDisposed) return;
    
    // Belum diimplementasi
    Get.snackbar(
      'Info',
      'Fitur Jadwal sedang dalam pengembangan',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// Logout
  Future<void> logout() async {
    if (_isDisposed) return;
    
    isLoading.value = true;
    
    try {
      final success = await _authRepository.logout();
      
      if (_isDisposed) return;
      
      if (success) {
        // Navigasi ke halaman login
        Get.offAllNamed(Routes.login);
      } else {
        // Masih coba logout meskipun API gagal
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      if (_isDisposed) return;
      
      errorMessage.value = e.toString();
      if (kDebugMode) {
        print("DEBUG - Logout error: ${errorMessage.value}");
      }
      
      // Masih coba logout meskipun terjadi error
      Get.offAllNamed(Routes.login);
    } finally {
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }
}