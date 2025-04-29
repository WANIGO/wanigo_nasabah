import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanigo_auth/screen/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _autoScrollTimer;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Kelola Sampah, Wujudkan Perubahan',
      'subtitle': 'Mulai memilah sampah dengan Apps4Waste! Langkah kecil untuk manajemen sampah yang lebih baik',
      'color': const Color(0xFF1E88E5), // Blue
    },
    {
      'title': 'Daur Ulang Untuk Masa Depan',
      'subtitle': 'Pelajari cara mendaur ulang yang benar dan kontribusikan untuk lingkungan yang lebih bersih',
      'color': const Color(0xFF43A047), // Green
    },
    {
      'title': 'Bergabung Dengan Komunitas',
      'subtitle': 'Terhubung dengan komunitas peduli lingkungan dan berbagi pengalaman pengelolaan sampah',
      'color': const Color(0xFFE65100), // Dark Orange to match your screenshot
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize PageController
    _pageController = PageController();
    // Start auto-scrolling timer
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    // Create a timer that triggers page change every 10 seconds
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // Calculate next page, with wraparound
      int nextPage = _currentPage + 1;
      if (nextPage >= _pages.length) {
        nextPage = 0;
      }
      
      // Apply the page change
      setState(() {
        _currentPage = nextPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color with animation
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: _pages[_currentPage]['color'],
            width: double.infinity,
            height: double.infinity,
          ),
          
          // Main content with swipe detection
          SafeArea(
            child: Column(
              children: [
                // Progress indicator at the top
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 3,
                          decoration: BoxDecoration(
                            color: index == _currentPage 
                                ? Colors.white 
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Swipeable content area (excludes buttons)
                Expanded(
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        // Swiped right - go to previous page
                        int previousPage = _currentPage - 1;
                        if (previousPage < 0) {
                          previousPage = _pages.length - 1;
                        }
                        setState(() {
                          _currentPage = previousPage;
                        });
                      } else if (details.primaryVelocity! < 0) {
                        // Swiped left - go to next page
                        setState(() {
                          _currentPage = (_currentPage + 1) % _pages.length;
                        });
                      }
                      
                      // Reset timer when user swipes
                      _autoScrollTimer.cancel();
                      _startAutoScroll();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Image at the top
                          AspectRatio(
                            aspectRatio: 1, // Square image
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/onboarding_ads.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Title with animation
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: Text(
                              _pages[_currentPage]['title'],
                              key: ValueKey<String>(_pages[_currentPage]['title']),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Subtitle with animation
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: Text(
                              _pages[_currentPage]['subtitle'],
                              key: ValueKey<String>(_pages[_currentPage]['subtitle']),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Button section - fixed, not part of swipe area
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      // Action buttons stay fixed while content changes
                      ElevatedButton(
                        onPressed: () {
                          // Cancel timer when navigating away
                          _autoScrollTimer.cancel();
                          
                          // Navigate to login screen using regular push
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _pages[_currentPage]['color'],
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Masuk Aplikasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      
                      OutlinedButton(
                        onPressed: () {
                          // Do nothing (as requested)
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 1.5),
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Coba Aplikasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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

  Widget _buildPageContent(Map<String, dynamic> pageData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            pageData['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Subtitle
          Text(
            pageData['subtitle'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}