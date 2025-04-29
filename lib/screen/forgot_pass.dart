import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-populate with email if provided
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black87),
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
                  color: const Color(0xFF1976D2),
                ),
                const Text(
                  "WANIGO!",
                  style: TextStyle(
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                      'assets/email_icon.png', // Make sure to add this asset
                      width: 110,
                      height: 110,
                      // If you don't have the exact asset, you can use:
                      // color: const Color(0xFF1976D2),
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.email,
                          size: 110,
                          color: const Color(0xFF1976D2),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Heading
                    const Text(
                      'Cek Email Sekarang!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Description text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Tautan untuk ganti kata sandi telah dikirim ke email ${_emailController.text} dan berlaku selama 24 jam. Periksa kotak masuk atau folder spam Anda. Pastikan alamat email anda sudah pernah terdaftar di aplikasi',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Return button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom wave decoration
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/wave_bottom.png', // Make sure to add this asset
              fit: BoxFit.fill,
              height: 110,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1976D2),
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