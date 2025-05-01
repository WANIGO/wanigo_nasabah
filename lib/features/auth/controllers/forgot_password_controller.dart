// File: lib/features/auth/controllers/forgot_password_controller.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  // Repository
  final AuthRepository _authRepository = AuthRepository();
  
  // Text Controller
  final TextEditingController emailController = TextEditingController();
  
  // State
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isEmailSent = false.obs;
  
  // Flag untuk menunjukkan controller sudah di-dispose
  bool _isDisposed = false;
  
  @override
  void onInit() {
    super.onInit();
    
    // Cek apakah ada email yang dikirim sebagai argument
    if (Get.arguments != null && Get.arguments is String) {
      final email = Get.arguments as String;
      if (email.isNotEmpty) {
        emailController.text = email;
        if (kDebugMode) {
          print("DEBUG - Email from arguments: $email");
        }
      }
    }
  }
  
  @override
  void onClose() {
    _isDisposed = true;
    emailController.dispose();
    super.onClose();
  }
  
  // Validasi format email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }
  
  // Proses forgot password / request reset password
  Future<void> forgotPassword() async {
    // Validasi email terlebih dahulu
    final emailValidation = validateEmail(emailController.text);
    if (emailValidation != null) {
      errorMessage.value = emailValidation;
      
      // Cek apakah controller sudah di-dispose
      if (!_isDisposed) {
        Get.snackbar(
          'Perhatian',
          errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
      return;
    }
    
    // Set loading state
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Panggil API forgot password menggunakan method forgotPassword di repository
      if (kDebugMode) {
        print("DEBUG - Calling repository forgotPassword with email: ${emailController.text}");
      }
      
      final success = await _authRepository.forgotPassword(emailController.text);
      
      // Cek apakah controller sudah di-dispose
      if (_isDisposed) return;
      
      if (success) {
        isEmailSent.value = true;
        
        // Tampilkan snackbar sukses
        Get.snackbar(
          'Berhasil',
          'Email reset password telah dikirim',
          backgroundColor: Colors.green[100],
          colorText: Colors.green[900],
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      } else {
        errorMessage.value = 'Gagal mengirim email reset password. Silakan coba lagi nanti.';
        
        // Tampilkan pesan error
        Get.snackbar(
          'Gagal',
          errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      // Cek apakah controller sudah di-dispose
      if (_isDisposed) return;
      
      if (kDebugMode) {
        print("DEBUG - Forgot password error: $e");
      }
      
      // Set error message berdasarkan jenis error
      if (e.toString().contains('not found') || 
          e.toString().contains('tidak ditemukan') ||
          e.toString().contains("can't find") ||
          e.toString().contains('not registered')) {
        errorMessage.value = 'Email tidak terdaftar di sistem kami';
      } else if (e.toString().contains('koneksi') || 
                e.toString().contains('connection')) {
        errorMessage.value = 'Gagal terhubung ke server. Silakan periksa koneksi internet Anda';
      } else {
        errorMessage.value = 'Gagal mengirim email reset password: ${e.toString()}';
      }
      
      // Tampilkan pesan error
      Get.snackbar(
        'Gagal',
        errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      // Jangan update state jika controller sudah di-dispose
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }
  
  // Method alternatif untuk backward compatibility
  Future<void> requestPasswordReset() async {
    await forgotPassword();
  }
  
  // Navigasi kembali ke halaman login
  void backToLogin() {
    // Cek apakah controller sudah di-dispose
    if (_isDisposed) return;
    
    Get.offAllNamed(Routes.login);
  }
}