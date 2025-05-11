import 'package:flutter/material.dart';
import 'package:wanigo_mitra/screen/mitra_login.dart'; // Import the login screen

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mitra_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Logo positioned exactly like in mitra_login.dart
              Positioned(
                top: screenHeight * 0.1 + 22,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/mitra_title.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              // Buttons at the bottom in a Column
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "Masuk Aplikasi" Button with specified color and navigation
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the LoginScreen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFFFFF), // White text
                            backgroundColor: const Color(0xFF0A5AEB), // Specified blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Masuk Aplikasi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      
                      // "Coba Aplikasi" Button without outline, white bg, blue text
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Try app action
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF084BC4), // Blue text
                            backgroundColor: const Color(0xFFFFFFFF), // White background
                            // No outline/border as requested
                            elevation: 0, // Removing shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Coba Aplikasi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}