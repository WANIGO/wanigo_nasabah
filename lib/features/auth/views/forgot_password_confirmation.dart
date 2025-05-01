import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

/// Screen yang ditampilkan setelah berhasil mengirim email reset password
class ForgotPasswordConfirmationScreen extends StatelessWidget {
  const ForgotPasswordConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil alamat email dari argumen
    final String email = Get.arguments is String ? Get.arguments : 'Anda';

    return BaseWidgetContainer(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        showBackButton: true,
        onBackPressed: () => Get.offAllNamed(Routes.login),
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Email icon
                    Image.asset(
                      'assets/images/email_icon.png',
                      width: 110,
                      height: 110,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.email,
                          size: 110,
                          color: AppColors.blue500,
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Heading
                    GlobalText(
                      text: 'Cek Email Sekarang!',
                      variant: TextVariant.h4,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Description text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GlobalText(
                        text: 'Tautan untuk ganti kata sandi telah dikirim ke email $email '
                              'dan berlaku selama 24 jam. Periksa kotak masuk atau folder spam Anda. '
                              'Pastikan alamat email anda sudah pernah terdaftar di aplikasi',
                        variant: TextVariant.mediumRegular,
                        color: AppColors.gray700,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Return to login button
                    GlobalButton(
                      text: 'Kembali ke Login',
                      variant: ButtonVariant.large,
                      onPressed: () => Get.offAllNamed(Routes.login),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom wave decoration - stays at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bg_main_bottom.png',
              fit: BoxFit.fill,
              height: 110,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.blue500,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}