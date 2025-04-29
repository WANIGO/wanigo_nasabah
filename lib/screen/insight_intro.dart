import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String userName;

  const WelcomeScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: null,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/WANIGO_logo.png',
                  width: 24,
                  height: 24,
                ),
                Text(
                  "WANIGO!",
                  style: TextStyle(
                    color: Color(0xFF0078FF),
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cloud background image with recycling icon overlay
            Stack(
              alignment: Alignment.center,
              children: [
                // Background image
                Image.asset(
                  'assets/bg_insight.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                
                // Recycling icon in the middle of the background without white container
                // Positioned slightly lower (10px down)
                Positioned(
                  top: 10, // Move 10px downward from center
                  child: Image.asset(
                    'assets/trash_recycle.png',
                    width: 240,
                    height: 240,
                  ),
                ),
              ],
            ),
            
            // Welcome text - positioned right after the background image
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: Text(
                'Selamat datang di WANIGO!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Sebelum mulai aksi kelola sampah, bantu kami mengenal Anda dengan mengisi WANIGO! Insight',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Flexible spacing
            
            // Start button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen after welcome
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0078FF),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Mulai Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Security note - light blue background with outline
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFDFE9FD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF052D76), width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF052D76),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'WANIGO! menjamin kerahasiaan dan data anda!',
                      style: TextStyle(
                        color: Color(0xFF052D76),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom wave decoration
            Image.asset(
              'assets/background_waves.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}