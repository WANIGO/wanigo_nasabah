// File: lib/routes/app_pages.dart

import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/waste_history/views/mitra_daftar_item_screen.dart';
import 'package:wanigo_nasabah/features/waste_history/views/mitra_detail_setoran_screen.dart';
import 'package:wanigo_nasabah/features/waste_history/views/mitra_pembelian_sampah_screen.dart';
import 'package:wanigo_nasabah/features/waste_history/views/mitra_setoran_sampah_screen.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

// Auth
import 'package:wanigo_nasabah/features/auth/bindings/auth_binding.dart';
// Gunakan import langsung ke file, bukan class
import 'package:wanigo_nasabah/features/auth/views/login_screen.dart' as login;
import 'package:wanigo_nasabah/features/auth/views/register_screen.dart' as register;
import 'package:wanigo_nasabah/features/auth/views/forgot_password.dart' as forgot_password;
import 'package:wanigo_nasabah/features/auth/views/forgot_password_confirmation.dart' as forgot_password_confirmation;
import 'package:wanigo_nasabah/features/auth/views/login_confirm.dart' as login_confirm;

// Splash dan Onboarding
import 'package:wanigo_nasabah/features/splash/views/splash_screen.dart';
import 'package:wanigo_nasabah/features/auth/views/insight_intro.dart';
import 'package:wanigo_nasabah/features/auth/views/onboarding_screen.dart';

// Home
import 'package:wanigo_nasabah/features/home/bindings/home_binding.dart';
import 'package:wanigo_nasabah/features/home/views/nasabah_home_page.dart';

// Profile
import 'package:wanigo_nasabah/features/profile/bindings/profile_binding.dart';
import 'package:wanigo_nasabah/features/profile/views/profile_screen.dart' as profile; 

// Middlewares
import 'package:wanigo_nasabah/features/profile/middleware/profile_step_guard.dart';

class AppPages {
  static final routes = [
    // SPLASH & ONBOARDING
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.insight,
      page: () => const InsightIntroScreen(),
      binding: AuthBinding(),
      middlewares: [ProfileStepGuard()], // TAMBAHAN: Middleware untuk mengecek status profil
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // AUTH
    GetPage(
      name: Routes.login,
      page: () => const login.LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.register,
      page: () => const register.RegisterScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const forgot_password.ForgotPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.forgotPasswordConfirmation,
      page: () => const forgot_password_confirmation.ForgotPasswordConfirmationScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.loginConfirm,
      page: () => const login_confirm.LoginConfirmScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // HOME
    GetPage(
      name: Routes.home,
      page: () => const NasabahHomePage(),
      binding: HomeBinding(),
      middlewares: [ProfileStepGuard()], // TAMBAHAN: Middleware untuk mengecek status profil
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // PROFILE STEPS
    GetPage(
      name: Routes.profileStep1,
      page: () => const profile.ProfileStep1Screen(),
      binding: ProfileBinding(),
      middlewares: [ProfileStepGuard()], // TAMBAHAN: Middleware untuk mengecek status profil
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.profileStep2,
      page: () => const profile.ProfileStep2Screen(),
      binding: ProfileBinding(),
      middlewares: [ProfileStepGuard()], // TAMBAHAN: Middleware untuk mengecek status profil
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.profileStep3,
      page: () => const profile.ProfileStep3Screen(),
      binding: ProfileBinding(),
      middlewares: [ProfileStepGuard()], // TAMBAHAN: Middleware untuk mengecek status profil
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.profileCompletion,
      page: () => const profile.ProfileCompletionScreen(),
      binding: ProfileBinding(),
      middlewares: [ProfileStepGuard()], // TAMBAHAN: Middleware untuk mengecek status profil
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),


    // Mitra History
    GetPage(
      name: Routes.mitraDaftarItem,
      page: () => MitraDaftarItemScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.mitraDetailSetoranSampah,
      page: () => const MitraDetailSetoranScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.mitraPembelianSampah,
      page: () => MitraPembelianSampahScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.mitraSetoranSampah,
      page: () => MitraSetoranSampahScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}