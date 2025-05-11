// File: lib/features/profile/middleware/profile_step_guard.dart

import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProfileStepGuard extends GetMiddleware {
  @override
  int? get priority => 9; // Set high priority for this middleware

  @override
  RouteSettings? redirect(String? route) {
    // Skip middleware for routes that should always be accessible
    if (route == Routes.splash || 
        route == Routes.login || 
        route == Routes.register || 
        route == Routes.forgotPassword ||
        route == Routes.forgotPasswordConfirmation ||
        route == Routes.loginConfirm ||
        route == Routes.onboarding) {
      return null;
    }

    final AuthController authController = Get.find<AuthController>();

    // Tambahkan log untuk debugging
    if (kDebugMode) {
      print('ProfileStepGuard.redirect - Current route: $route');
      print('ProfileStepGuard.redirect - isLoggedIn: ${authController.isLoggedIn.value}');
      
      if (authController.profileStatus.value != null) {
        print('ProfileStepGuard.redirect - profileStatus.isCompleted: ${authController.profileStatus.value!.isCompleted}');
        print('ProfileStepGuard.redirect - profileStatus.nextStep: ${authController.profileStatus.value!.nextStep}');
        print('ProfileStepGuard.redirect - profileStatus.completionPercentage: ${authController.profileStatus.value!.completionPercentage}');
      } else {
        print('ProfileStepGuard.redirect - profileStatus is null');
      }
      
      if (authController.user.value?.nasabah != null) {
        print('ProfileStepGuard.redirect - jenis_sampah_dikelola: ${authController.user.value?.nasabah?.jenisSampahDikelola}');
        print('ProfileStepGuard.redirect - profileCompletedAt: ${authController.user.value?.nasabah?.profileCompletedAt}');
      }
    }

    // Jika belum login, arahkan ke login
    if (!authController.isLoggedIn.value) {
      if (kDebugMode) {
        print('ProfileStepGuard.redirect - Not logged in, redirecting to login');
      }
      return const RouteSettings(name: Routes.login);
    }

    // PERBAIKAN: Cek field jenis_sampah_dikelola terlebih dahulu sebagai indikator profil lengkap
    if (authController.user.value?.nasabah != null && 
        authController.user.value!.nasabah!.jenisSampahDikelola != null && 
        authController.user.value!.nasabah!.jenisSampahDikelola!.isNotEmpty) {
      
      // Jika rute saat ini adalah salah satu dari step profile atau insight,
      // maka arahkan ke home karena profile sebenarnya sudah lengkap
      if (route == Routes.profileStep1 || 
          route == Routes.profileStep2 || 
          route == Routes.profileStep3 || 
          route == Routes.insight) {
        
        if (kDebugMode) {
          print('ProfileStepGuard.redirect - Profile complete based on jenis_sampah_dikelola, redirecting to home');
        }
        return const RouteSettings(name: Routes.home);
      }
      
      // Jika rute lain, biarkan (tidak perlu redirect)
      return null;
    }

    // Jika profile belum lengkap, periksa status
    final profileStatus = authController.profileStatus.value;
    if (profileStatus != null && !profileStatus.isCompleted) {
      // Jika mencoba mengakses halaman home tapi profil belum lengkap
      if (route == Routes.home) {
        if (kDebugMode) {
          print('ProfileStepGuard.redirect - Trying to access home with incomplete profile');
        }
        
        // Method navigateBasedOnProfileStatus sudah tersedia di AuthController
        // Tidak perlu memanggil checkProfileStatus yang tidak ada
        authController.navigateBasedOnProfileStatus();
        
        if (profileStatus.nextStep.isEmpty) {
          // Jika nextStep kosong, arahkan ke insight intro
          return RouteSettings(
            name: Routes.insight, 
            arguments: authController.user.value?.name ?? ''
          );
        } else {
          // Arahkan ke step yang sesuai
          switch (profileStatus.nextStep) {
            case 'step1':
              return const RouteSettings(name: Routes.profileStep1);
            case 'step2':
              return const RouteSettings(name: Routes.profileStep2);
            case 'step3':
              return const RouteSettings(name: Routes.profileStep3);
            default:
              return RouteSettings(
                name: Routes.insight,
                arguments: authController.user.value?.name ?? ''
              );
          }
        }
      }
      
      // PERBAIKAN: Tambahkan pengecekan untuk menghindari navigasi mundur pada step
      if (route == Routes.profileStep2 && profileStatus.nextStep == 'step1') {
        if (kDebugMode) {
          print('ProfileStepGuard.redirect - Trying to access step2 when step1 is required');
        }
        return const RouteSettings(name: Routes.profileStep1);
      }
      
      if (route == Routes.profileStep3 && 
         (profileStatus.nextStep == 'step1' || profileStatus.nextStep == 'step2')) {
        if (kDebugMode) {
          print('ProfileStepGuard.redirect - Trying to access step3 when earlier steps are required');
        }
        
        // Redirect ke step yang sesuai
        if (profileStatus.nextStep == 'step1') {
          return const RouteSettings(name: Routes.profileStep1);
        } else {
          return const RouteSettings(name: Routes.profileStep2);
        }
      }
    }

    // Jika sudah lengkap dan mencoba mengakses step profile, arahkan ke home
    if (profileStatus != null && profileStatus.isCompleted && 
        (route == Routes.profileStep1 || 
         route == Routes.profileStep2 || 
         route == Routes.profileStep3 || 
         route == Routes.insight)) {
      if (kDebugMode) {
        print('ProfileStepGuard.redirect - Profile complete, redirecting to home');
      }
      return const RouteSettings(name: Routes.home);
    }

    // Jika tidak ada kondisi khusus, biarkan navigasi normal
    return null;
  }
}