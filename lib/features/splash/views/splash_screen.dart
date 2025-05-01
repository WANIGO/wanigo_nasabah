import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Menggunakan repository langsung
  final AuthRepository _authRepository = AuthRepository();
  
  // Flag untuk mencegah operasi setelah widget di-dispose
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    
    // Setup animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    
    _animationController.forward();
    
    // Check login status and navigate accordingly after delay
    _checkLoginAndNavigate();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController.dispose();
    super.dispose();
  }
  
  void _checkLoginAndNavigate() async {
    // Berikan waktu untuk splash screen ditampilkan
    await Future.delayed(const Duration(seconds: 3));
    
    // Cek apakah widget sudah di-dispose
    if (_isDisposed) return;
    
    try {
      // Cek token untuk menentukan status login
      final token = await _authRepository.getToken();
      final isLoggedIn = token != null && token.isNotEmpty;
      
      if (isLoggedIn) {
        if (kDebugMode) {
          print("DEBUG - User sudah login, memeriksa status profil");
        }
        
        try {
          // Ambil data user
          final user = await _authRepository.getUser();
          
          // Cek status profil
          final profileStatus = await _authRepository.getProfileStatus();
          
          // Cek apakah widget sudah di-dispose
          if (_isDisposed) return;
          
          if (profileStatus != null && profileStatus.isCompleted) {
            // Profil sudah lengkap, navigasi ke home
            if (kDebugMode) {
              print("DEBUG - Profil sudah lengkap, navigasi ke home");
            }
            Get.offAllNamed(Routes.home);
          } else if (profileStatus != null && profileStatus.nextStep.isNotEmpty) {
            // Navigasi ke step yang sesuai
            if (kDebugMode) {
              print("DEBUG - Profil belum lengkap, navigasi ke step: ${profileStatus.nextStep}");
            }
            
            switch (profileStatus.nextStep) {
              case 'step1':
                Get.offAllNamed(Routes.profileStep1);
                break;
              case 'step2':
                Get.offAllNamed(Routes.profileStep2);
                break;
              case 'step3':
                Get.offAllNamed(Routes.profileStep3);
                break;
              default:
                Get.offAllNamed(Routes.insight, arguments: user?.name ?? "");
            }
          } else {
            // Tidak ada data profil atau nextStep kosong, navigasi ke insight
            if (kDebugMode) {
              print("DEBUG - Tidak ada data profil, navigasi ke insight intro");
            }
            Get.offAllNamed(Routes.insight, arguments: user?.name ?? "");
          }
        } catch (e) {
          // Error saat mengambil status profil
          if (kDebugMode) {
            print("DEBUG - Error saat memeriksa status profil: $e");
          }
          
          // Cek apakah widget sudah di-dispose
          if (_isDisposed) return;
          
          // Arahkan ke onboarding sebagai fallback
          Get.offAllNamed(Routes.onboarding);
        }
      } else {
        // User belum login, arahkan ke onboarding
        if (kDebugMode) {
          print("DEBUG - User belum login, navigasi ke onboarding");
        }
        
        // Cek apakah widget sudah di-dispose
        if (_isDisposed) return;
        
        Get.offAllNamed(Routes.onboarding);
      }
    } catch (e) {
      // Error saat memeriksa status login
      if (kDebugMode) {
        print("DEBUG - Error saat memeriksa status login: $e");
      }
      
      // Cek apakah widget sudah di-dispose
      if (_isDisposed) return;
      
      // Arahkan ke onboarding sebagai fallback
      Get.offAllNamed(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo
                Image.asset(
                  'assets/images/trash_recycle.png',
                  width: 180,
                  height: 180,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.recycling,
                        size: 100,
                        color: Color(0xFF1976D2),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                
                // App name
                const Text(
                  'WANIGO!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // App slogan/description
                const Text(
                  'Kelola Sampah dengan Bijak',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Loading indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1976D2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}