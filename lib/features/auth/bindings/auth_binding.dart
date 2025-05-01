// File: lib/features/auth/bindings/auth_binding.dart

import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart';
import 'package:wanigo_nasabah/features/auth/controllers/login_controller.dart';
import 'package:wanigo_nasabah/features/auth/controllers/login_confirm_controller.dart';
import 'package:wanigo_nasabah/features/auth/controllers/register_controller.dart';
import 'package:wanigo_nasabah/features/auth/controllers/forgot_password_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    // Main auth controller
    // Jangan gunakan Get.put jika sudah ada instance yang ditandai sebagai permanen
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(), permanent: true);
    }
    
    // Specific auth controllers - menggunakan lazyPut untuk menghindari konflik
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<LoginConfirmController>(() => LoginConfirmController(), fenix: true);
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(), fenix: true);
  }
}