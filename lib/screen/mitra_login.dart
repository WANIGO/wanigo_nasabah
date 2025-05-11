import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:wanigo_mitra/screen/mitra_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  // State for email registration status: 0 = not registered, 1 = registered
  int _emailStatus = 1;
  // Add state variable for email validation
  bool _isEmailValid = true;
  String _emailErrorMessage = '';
  
  // Regular expression for validating email format
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  // Function to validate email format
  bool _validateEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        _isEmailValid = false;
        _emailErrorMessage = 'Email tidak boleh kosong';
      });
      return false;
    } else if (!_emailRegExp.hasMatch(email)) {
      setState(() {
        _isEmailValid = false;
        _emailErrorMessage = 'Format email tidak valid';
      });
      return false;
    } else {
      setState(() {
        _isEmailValid = true;
        _emailErrorMessage = '';
      });
      return true;
    }
  }

  // Mock function to check if email is registered
  int checkEmailStatus(String email) {
    // This is a mock implementation
    // In a real app, you would check against your backend or local database
    // For testing purposes:
    // Return 0 if email contains "test" or is empty, otherwise return 1
    if (email.isEmpty || email.contains("test")) {
      return 0; // Not registered
    }
    return 1; // Registered
  }

  // Function to handle login button press
  void _handleLogin() {
    final email = _emailController.text.trim();
    
    // First validate the email format
    if (!_validateEmail(email)) {
      return; // Stop if email format is invalid
    }
    
    // Then check registration status
    final status = checkEmailStatus(email);
    
    setState(() {
      _emailStatus = status;
    });
    
    if (status == 0) {
      // Show the popup for unregistered email
      _showUnregisteredEmailDialog();
    } else {
      // Proceed with normal login flow
      // Navigate to home or dashboard
      print("Proceeding with login for registered email: $email");
    }
  }
  
  // Show dialog for unregistered email
  void _showUnregisteredEmailDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners as requested
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email icon from assets without background
                Image.asset(
                  'assets/no_mail.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
                
                const SizedBox(height: 24),
                
                // Title
                const Text(
                  'Email Belum Terdaftar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Description
                Text(
                  'Email ini belum terdaftar di WANIGO. Ingin melanjutkan pendaftaran?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Continue registration button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      // Navigate to registration page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MitraFormScreen(
                            email: _emailController.text.trim(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF0A5AEB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Lanjutkan Pendaftaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Back button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background image container taking full screen
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/mitra_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Logo positioned with final adjustment (lowered by an additional 7px)
          Positioned(
            // Total adjustment: 5 + 10 + 7 = 22px
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
          
          // White background container with squared corners
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                // No rounded corners as requested
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Motivational text
                  const Text(
                    'Berani Kelola Sampah,\nMulai dari Sekarang 🔥',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Email label
                  const Text(
                    'Alamat Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Email text field with validation error
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat anda disini',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _isEmailValid ? Colors.grey[300]! : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _isEmailValid ? const Color(0xFF0A5AEB) : Colors.red,
                        ),
                      ),
                      errorText: _isEmailValid ? null : _emailErrorMessage,
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // Optional: validate on change to give immediate feedback
                    onChanged: (value) {
                      if (!_isEmailValid) {
                        _validateEmail(value.trim());
                      }
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin, // Use our new handler
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF0A5AEB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                  
                  const SizedBox(height: 16),
                  
                  // Terms and conditions text
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Dengan melanjutkan, Anda menyetujui ',
                        ),
                        TextSpan(
                          text: 'Kebijakan Privasi',
                          style: const TextStyle(
                            color: Color(0xFF0A5AEB),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to privacy policy
                            },
                        ),
                        const TextSpan(
                          text: ' yang berlaku di WANIGO!',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}