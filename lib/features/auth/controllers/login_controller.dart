import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

/// Controller untuk halaman login
class LoginController extends GetxController {
  // Controller text untuk email input
  late TextEditingController emailController;
  
  // State variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Reference ke main auth controller dan repository
  final AuthController _authController = Get.find<AuthController>();
  final AuthRepository _authRepository = AuthRepository();
  
  // Variable untuk menyimpan email sebelum navigasi
  String? _cachedEmail;
  
  // Variabel untuk memeriksa apakah controller di-dispose atau tidak
  bool _isDisposed = false;
  
  // Variabel untuk membatasi request berulang
  DateTime? _lastEmailCheckTime;
  static const Duration _emailCheckThrottleTime = Duration(milliseconds: 500);
  
  @override
  void onInit() {
    super.onInit();
    print("DEBUG - Login controller initialized");
    
    // Inisialisasi controller
    emailController = TextEditingController();
    
    // Pre-fill email jika ada dari route sebelumnya
    final args = Get.arguments;
    if (args != null && args is Map && args.containsKey('email')) {
      emailController.text = args['email'];
      print("DEBUG - Email prefilled with: ${emailController.text}");
    }
  }
  
  @override
  void onClose() {
    _isDisposed = true; // Tandai bahwa controller sedang di-dispose
    emailController.dispose();
    super.onClose();
  }
  
  /// Validasi format email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }
  
  /// Cek email dan navigasi ke halaman selanjutnya
  Future<void> checkEmailAndNavigate() async {
    // Jika controller sudah di-dispose, jangan lanjutkan
    if (_isDisposed) {
      print("DEBUG - Controller already disposed, cancelling operation");
      return;
    }
    
    // Hindari request beruntun terlalu cepat
    if (_lastEmailCheckTime != null) {
      final difference = DateTime.now().difference(_lastEmailCheckTime!);
      if (difference < _emailCheckThrottleTime) {
        print("DEBUG - Throttling email check request. Time since last request: ${difference.inMilliseconds}ms");
        return;
      }
    }
    _lastEmailCheckTime = DateTime.now();
    
    // Reset error message jika ada
    errorMessage.value = '';
    
    // Cache email sebelum validasi untuk menghindari akses ke emailController yang sudah di-dispose
    final String emailToCheck = emailController.text.trim().toLowerCase();
    _cachedEmail = emailToCheck; // Simpan email dalam cache
    
    // Validasi email terlebih dahulu
    final emailValidation = validateEmail(emailToCheck);
    if (emailValidation != null) {
      errorMessage.value = emailValidation;
      
      // Pastikan tidak menampilkan snackbar jika controller di-dispose
      if (!_isDisposed) {
        Get.snackbar(
          'Perhatian',
          errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
      }
      return;
    }
    
    isLoading.value = true;
    
    try {
      print("DEBUG - Checking email: $emailToCheck");
      
      // Gunakan repository untuk cek email
      final response = await _authRepository.checkEmail(emailToCheck);
      
      // Debug print untuk melihat struktur respons
      print("DEBUG - Check Email API Full Response: $response");
      
      // Jika controller sudah di-dispose, hentikan proses
      if (_isDisposed) return;
      
      // Format response yang konsisten berdasarkan struktur API yang dijelaskan di dokumentasi
      if (response.containsKey('status') && response['status'] == 'success') {
        // Ambil data dari respons API
        final data = response.containsKey('data') ? response['data'] : null;
        
        // Debug print untuk melihat data
        print("DEBUG - Response data: $data");
        
        if (data != null) {
          // Periksa email_exists sesuai dengan spesifikasi API
          final bool emailExists = data.containsKey('email_exists') ? 
              data['email_exists'] : false;
          
          final String? role = emailExists && data.containsKey('role') ? 
              data['role'] : null;
          
          print("DEBUG - Email exists: $emailExists, Role: $role");
          
          if (emailExists) {
            // Periksa apakah role adalah nasabah
            if (role == 'nasabah') {
              // Email terdaftar dan role nasabah, navigasi ke login confirm
              print("DEBUG - Email terdaftar dengan role nasabah, navigasi ke login confirm");
              
              // Hindari navigasi jika controller sudah di-dispose
              if (!_isDisposed) {
                // Gunakan cached email untuk navigasi
                Get.toNamed(Routes.loginConfirm, arguments: _cachedEmail);
              }
            } else {
              // Email terdaftar tapi bukan role nasabah
              errorMessage.value = "Email ini terdaftar dengan role '$role', bukan nasabah.";
              
              // Pastikan tidak menampilkan snackbar jika controller di-dispose
              if (!_isDisposed) {
                Get.snackbar(
                  'Perhatian',
                  errorMessage.value,
                  backgroundColor: Colors.orange[100],
                  colorText: Colors.orange[900],
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 5),
                );
              }
            }
          } else {
            // Email belum terdaftar, tampilkan dialog
            print("DEBUG - Email belum terdaftar, tampilkan dialog");
            // Cek apakah controller masih aktif
            if (!_isDisposed) {
              // Gunakan cached email untuk dialog
              _showEmailNotRegisteredDialog(_cachedEmail!);
            }
          }
        } else {
          // Data tidak ditemukan
          handleApiError("Data tidak valid dari server");
        }
      } else {
        // Status bukan success
        String message = response.containsKey('message') ? response['message'] : 'Gagal memeriksa email';
        handleApiError(message);
      }
    } catch (e) {
      if (_isDisposed) return; // Hindari update state jika sudah di-dispose
      
      errorMessage.value = e.toString();
      print("DEBUG - Exception dalam checkEmailAndNavigate: $e");
      
      // Cek jika error terkait koneksi, gunakan fallback data
      if (e.toString().contains('koneksi') || 
          e.toString().contains('network') || 
          e.toString().contains('Failed host lookup')) {
        _showConnectionErrorDialog(emailToCheck);
        return;
      }
      
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (!_isDisposed) { // Pastikan controller belum di-dispose sebelum update
        isLoading.value = false;
      }
    }
  }
  
  // Helper method untuk menangani error API
  void handleApiError(String message) {
    if (_isDisposed) return;
    
    errorMessage.value = message;
    print("DEBUG - API Error: $message");
    
    // Jika error terkait koneksi, tampilkan ConnectionErrorDialog
    if (errorMessage.value.contains('koneksi') || 
        errorMessage.value.contains('network') ||
        errorMessage.value.contains('Failed host lookup')) {
      
      // Tampilkan dialog koneksi
      if (_cachedEmail != null) {
        _showConnectionErrorDialog(_cachedEmail!);
      }
      return;
    }
    
    Get.snackbar(
      'Error',
      errorMessage.value,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }
  
  /// Menampilkan dialog email belum terdaftar
  void _showEmailNotRegisteredDialog(String email) {
    // Pastikan dialog ditampilkan
    print("DEBUG - Showing email not registered dialog for: $email");
    
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email icon - gunakan Icon bukan Image untuk menghindari error asset
              Icon(
                Icons.email,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              
              // Title text
              Text(
                "Email Belum Terdaftar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Description text
              Text(
                "Email $email belum terdaftar di WANIGO. Ingin melanjutkan pendaftaran?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              
              // Continue registration button
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  print("DEBUG - Navigating to register with email: $email");
                  
                  // Cek apakah controller masih aktif
                  if (!_isDisposed) {
                    // Navigate to registration form screen with the entered email
                    Get.toNamed(
                      Routes.register,
                      arguments: email,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2), // Deeper blue
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lanjutkan Pendaftaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
              // Back button
              OutlinedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey.shade300),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // User harus pilih salah satu tombol
    );
  }
  
  /// Menampilkan dialog error koneksi
  void _showConnectionErrorDialog(String email) {
    if (_isDisposed) return;
    
    print("DEBUG - Showing connection error dialog for: $email");
    
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Network error icon
              Icon(
                Icons.signal_wifi_off,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              
              // Title text
              Text(
                "Koneksi Bermasalah",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Description text
              Text(
                "Tidak dapat terhubung ke server. Silahkan periksa koneksi internet Anda atau lanjutkan dengan email ini.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              
              // Lanjutkan dengan email ini button
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  print("DEBUG - Proceeding with email despite connection issues: $email");
                  
                  // Cek apakah controller masih aktif
                  if (!_isDisposed) {
                    // Navigasi ke login confirm atau register berdasarkan email
                    if (email == 'test@example.com') {
                      // Assume this is a test email
                      Get.toNamed(Routes.loginConfirm, arguments: email);
                    } else {
                      // Untuk email lain, anggap belum terdaftar
                      _showEmailNotRegisteredDialog(email);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lanjutkan Dengan Email Ini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
              // Coba lagi button
              OutlinedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  
                  // Cek apakah controller masih aktif
                  if (!_isDisposed) {
                    checkEmailAndNavigate(); // Try again
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey.shade300),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Coba Lagi',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // User harus pilih salah satu tombol
    );
  }
}