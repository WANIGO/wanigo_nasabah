// File: lib/features/auth/views/register_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart' hide GlobalAppBar; // Hide GlobalAppBar dari wanigo_ui
import 'package:wanigo_nasabah/features/auth/controllers/register_controller.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:wanigo_nasabah/widgets/global_app_bar.dart'; // Import GlobalAppBar lokal


class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      backgroundColor: Colors.white,
      // Gunakan GlobalAppBar dari lokal
      appBar: GlobalAppBar(
        showBackButton: true,
        onBackPressed: () => Get.offAllNamed(Routes.login),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Bottom decoration image yang paling bawah, tapi dengan IgnorePointer
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Image.asset(
                  'assets/images/bg_main_bottom.png',
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.blue100.withOpacity(0.3),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Main content with scroll - di atas decoration untuk bisa scrollable
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: GlobalKey<FormState>(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan pencil emoji + micro-interaction
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            GlobalText(
                              text: 'Form Pendaftaran',
                              variant: TextVariant.h4,
                            ),
                            const SizedBox(width: 8),
                            const Text('✏️', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Subheader dengan email + subtle animation
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 10 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              text: 'Lanjutkan proses pendaftaran dengan email:',
                              variant: TextVariant.smallRegular,
                              color: AppColors.gray800,
                            ),
                            GlobalText(
                              text: controller.emailController.text,
                              variant: TextVariant.smallSemiBold,
                              color: AppColors.gray800,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Form fields with micro-interactions
                      AnimatedFormFields(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name field
                            GlobalText(
                              text: 'Nama Lengkap Nasabah',
                              variant: TextVariant.smallSemiBold,
                            ),
                            const SizedBox(height: 8),
                            Obx(() => GlobalTextField(
                              controller: controller.nameController,
                              hint: 'Masukkan nama lengkap anda',
                              errorText: controller.nameError.value.isEmpty 
                                  ? null 
                                  : controller.nameError.value,
                              onChanged: (value) {
                                if (controller.nameError.value.isNotEmpty) {
                                  controller.nameError.value = '';
                                }
                              },
                            )),
                            const SizedBox(height: 16),
                            
                            // Phone field
                            GlobalText(
                              text: 'Nomor Telepon Nasabah',
                              variant: TextVariant.smallSemiBold,
                            ),
                            const SizedBox(height: 8),
                            Obx(() => GlobalTextField(
                              controller: controller.phoneController,
                              hint: 'Masukkan nomor telepon anda',
                              keyboardType: TextInputType.phone,
                              errorText: controller.phoneError.value.isEmpty 
                                  ? null 
                                  : controller.phoneError.value,
                              onChanged: (value) {
                                if (controller.phoneError.value.isNotEmpty) {
                                  controller.phoneError.value = '';
                                }
                              },
                            )),
                            const SizedBox(height: 16),
                            
                            // Password field
                            GlobalText(
                              text: 'Kata Sandi',
                              variant: TextVariant.smallSemiBold,
                            ),
                            const SizedBox(height: 8),
                            Obx(() => GlobalTextField(
                              controller: controller.passwordController,
                              hint: 'Masukkan kata sandi anda disini',
                              obscureText: controller.obscurePassword.value,
                              errorText: controller.passwordError.value.isEmpty 
                                  ? null 
                                  : controller.passwordError.value,
                              onChanged: (value) {
                                if (controller.passwordError.value.isNotEmpty) {
                                  controller.passwordError.value = '';
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
                            const SizedBox(height: 16),
                            
                            // Confirm Password field
                            GlobalText(
                              text: 'Ulangi Kata Sandi',
                              variant: TextVariant.smallSemiBold,
                            ),
                            const SizedBox(height: 8),
                            Obx(() => GlobalTextField(
                              controller: controller.confirmPasswordController,
                              hint: 'Masukkan ulang kata sandi anda disini',
                              obscureText: controller.obscureConfirmPassword.value,
                              errorText: controller.confirmPasswordError.value.isEmpty 
                                  ? null 
                                  : controller.confirmPasswordError.value,
                              onChanged: (value) {
                                if (controller.confirmPasswordError.value.isNotEmpty) {
                                  controller.confirmPasswordError.value = '';
                                }
                              },
                              suffixIcon: GestureDetector(
                                onTap: controller.toggleConfirmPasswordVisibility,
                                child: Icon(
                                  controller.obscureConfirmPassword.value 
                                    ? Icons.visibility_off 
                                    : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                            const SizedBox(height: 32),
                            
                            // Error message if any
                            Obx(() => controller.errorMessage.value.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: GlobalText(
                                    text: controller.errorMessage.value,
                                    variant: TextVariant.smallRegular,
                                    color: AppColors.red500,
                                  ),
                                )
                              : const SizedBox.shrink()
                            ),
                            
                            // Button with pulse animation when enabled
                            Obx(() {
                              final bool isEnabled = controller.formFilled.value && !controller.isLoading.value;
                              
                              return ButtonWithPulse(
                                isEnabled: isEnabled,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blue500,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: Colors.grey[300],
                                      disabledForegroundColor: Colors.grey[600],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: isEnabled
                                        ? () => controller.register() 
                                        : null,
                                    child: controller.isLoading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        : const Text(
                                            'Lanjutkan',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            }),
                            
                            // Space for bottom image margin
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for animated form fields
class AnimatedFormFields extends StatelessWidget {
  final Widget child;
  
  const AnimatedFormFields({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutQuad,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

// Widget for button with pulse animation
class ButtonWithPulse extends StatefulWidget {
  final Widget child;
  final bool isEnabled;
  
  const ButtonWithPulse({
    Key? key,
    required this.child,
    required this.isEnabled,
  }) : super(key: key);
  
  @override
  State<ButtonWithPulse> createState() => _ButtonWithPulseState();
}

class _ButtonWithPulseState extends State<ButtonWithPulse> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.03),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.03, end: 1.0),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    ));
    
    _animController.repeat();
  }
  
  @override
  void didUpdateWidget(ButtonWithPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled != oldWidget.isEnabled) {
      if (widget.isEnabled) {
        _animController.repeat();
      } else {
        _animController.stop();
        _animController.reset();
      }
    }
  }
  
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) {
      return widget.child;
    }
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}