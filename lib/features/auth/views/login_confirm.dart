import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart' hide GlobalAppBar, ButtonStyle; // Hide GlobalAppBar dari wanigo_ui
import 'package:wanigo_nasabah/features/auth/controllers/login_confirm_controller.dart';
import 'package:wanigo_nasabah/widgets/global_app_bar.dart'; // Import GlobalAppBar lokal

class LoginConfirmScreen extends GetView<LoginConfirmController> {
  const LoginConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(
        showBackButton: true,
        onBackPressed: () => Get.back(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Konten utama dengan padding dan scroll untuk layar kecil
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App logo - Gunakan Icon sebagai pengganti Image.asset yang bermasalah
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.blue100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.recycling,
                          size: 50,
                          color: AppColors.blue500,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Heading
                    GlobalText(
                      text: 'Masuk Akun WANIGO!',
                      variant: TextVariant.h4,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Email instructions
                    GlobalText(
                      text: 'Masukkan kata sandi akun dengan email:',
                      variant: TextVariant.mediumRegular,
                      color: AppColors.gray600,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Email text with underline
                    GlobalText(
                      text: controller.email,
                      variant: TextVariant.mediumMedium,
                      color: AppColors.gray600,
                      textAlign: TextAlign.center,
                      decoration: TextDecoration.underline,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Password input
                    Obx(() => GlobalTextField(
                      controller: controller.passwordController,
                      hint: 'Masukkan kata sandi anda disini',
                      obscureText: controller.obscurePassword.value,
                      errorText: controller.errorMessage.value.isEmpty 
                          ? null 
                          : controller.errorMessage.value,
                      onChanged: (value) {
                        // Clear error message when user types
                        if (controller.errorMessage.value.isNotEmpty) {
                          controller.errorMessage.value = '';
                        }
                      },
                      suffixIcon: GestureDetector(
                        onTap: controller.togglePasswordVisibility,
                        child: Icon(
                          controller.obscurePassword.value 
                            ? Icons.visibility_off 
                            : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    )),
                    
                    const SizedBox(height: 24),
                    
                    // Login button - menggunakan ElevatedButton sebagai fallback untuk menghindari masalah dengan GlobalButton
                    Obx(() => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue500,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: controller.isLoading.value 
                          ? null 
                          : controller.login,
                        child: controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Masuk Aplikasi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    )),
                    
                    const SizedBox(height: 16),
                    
                    // Forgot password text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray800,
                        ),
                        children: [
                          const TextSpan(text: 'Lupa kata sandi? Klik '),
                          TextSpan(
                            text: 'Lupa Kata Sandi',
                            style: TextStyle(
                              color: AppColors.blue500,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.goToForgotPassword,
                          ),
                        ],
                      ),
                    ),
                    
                    // Show error message if any
                    Obx(() => controller.errorMessage.value.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gagal Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  controller.errorMessage.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red[900],
                                  ),
                                ),
                              ],
                            ),
                          )
                        )
                      : const SizedBox.shrink()
                    ),
                    
                    // Space untuk bottom image
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
            
            // Bottom decoration - Ganti dengan bg_main_bottom.png
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(  // Tambahkan IgnorePointer agar tidak menghalangi interaksi
                child: Image.asset(
                  'assets/images/bg_main_bottom.png',  // Gunakan bg_main_bottom.png seperti di halaman lain
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback jika gambar tidak ditemukan
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            AppColors.blue100.withOpacity(0.5),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}