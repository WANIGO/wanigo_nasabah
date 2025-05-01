import 'package:flutter/material.dart' hide ButtonStyle;
import 'dart:async';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart'; // TAMBAHKAN INI

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _autoScrollTimer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // TAMBAHKAN: Akses AuthController untuk menyimpan status onboarding
  late AuthController _authController;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Kelola Sampah, Wujudkan Perubahan',
      'subtitle': 'Mulai memilah sampah dengan WANIGO! Langkah kecil untuk manajemen sampah yang lebih baik',
      'image': 'assets/images/onboarding_ads.png',
    },
    {
      'title': 'Daur Ulang Untuk Masa Depan',
      'subtitle': 'Pelajari cara mendaur ulang yang benar dan kontribusikan untuk lingkungan yang lebih bersih',
      'image': 'assets/images/onboarding_ads.png',
    },
    {
      'title': 'Bergabung Dengan Komunitas',
      'subtitle': 'Terhubung dengan komunitas peduli lingkungan dan berbagi pengalaman pengelolaan sampah',
      'image': 'assets/images/onboarding_ads.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Dapatkan AuthController
    _authController = Get.find<AuthController>();
    
    // Initialize PageController
    _pageController = PageController();
    
    // Initialize Animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
    
    // Start auto-scrolling timer
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    // Create a timer that triggers page change every 8 seconds
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      // Calculate next page, with wraparound
      int nextPage = _currentPage + 1;
      if (nextPage >= _pages.length) {
        nextPage = 0;
      }
      
      // Apply the page change with animation
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int page) {
    _animationController.reset();
    setState(() {
      _currentPage = page;
    });
    _animationController.forward();
  }

  // TAMBAHKAN: Fungsi untuk menyimpan status onboarding dan navigasi
  void _completeOnboardingAndNavigate() {
    // Cancel timer when navigating away
    _autoScrollTimer.cancel();
    
    // Simpan status bahwa onboarding sudah dilihat
    _authController.setOnboardingComplete();
    
    // Navigate to login screen using Get
    Get.offAllNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0026FF), Color(0xFF0038FF)],
              ),
            ),
          ),
          
          // Main content with swipe detection
          SafeArea(
            child: Column(
              children: [
                // Progress indicator at the top
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 4,
                          decoration: BoxDecoration(
                            color: index == _currentPage 
                                ? Colors.white 
                                : Colors.white.withAlpha(77),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Swipeable content area (excludes buttons)
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return _buildPage(index);
                    },
                  ),
                ),
                
                // Button section - fixed, not part of swipe area
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Column(
                    children: [
                      // Login button - Using GlobalButton from wanigo_ui
                      GlobalButton(
                        text: 'Masuk Aplikasi',
                        variant: ButtonVariant.medium,
                        onPressed: _completeOnboardingAndNavigate, // UBAH: Gunakan fungsi baru
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Try app button - Using GlobalButton with secondary style
                      GlobalButton(
                        text: 'Coba Aplikasi',
                        variant: ButtonVariant.medium,
                        style: ButtonStyle.secondary,
                        onPressed: _completeOnboardingAndNavigate, // UBAH: Gunakan fungsi baru
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    final pageData = _pages[index];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image at the top with animation
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Image.asset(
                  pageData['image'],
                  height: 240,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 240,
                      width: 240,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          // Title with animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              pageData['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Subtitle with animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              pageData['subtitle'],
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.white.withAlpha(230),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}