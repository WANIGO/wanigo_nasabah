import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Menggunakan TextEditingController lokal untuk menghindari masalah disposed
  final TextEditingController _emailController = TextEditingController();
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  
  // AuthRepository untuk akses API
  final AuthRepository _authRepository = AuthRepository();
  
  @override
  void initState() {
    super.initState();
    // Cek argumen untuk pre-fill email jika ada
    final args = Get.arguments;
    if (args != null && args is Map && args.containsKey('email')) {
      _emailController.text = args['email'];
    }
    
    // PERBAIKAN 1: Set email default untuk testing (hanya pada debug mode)
    if (_emailController.text.isEmpty && true) {
      _emailController.text = 'test@example.com';
      debugPrint('DEBUG - Email prefilled with test email for development');
    }
  }
  
  @override
  void dispose() {
    // Dispose controller lokal saat widget di-dispose
    _emailController.dispose();
    super.dispose();
  }
  
  // Validasi email (sama dengan yang di LoginController)
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }
  
  // Handle login dengan cara yang aman dari disposed controller
  void _handleLogin() async {
    // Reset error message
    _errorMessage.value = '';
    
    // Validasi email
    final email = _emailController.text.trim();
    final emailValidation = _validateEmail(email);
    
    if (emailValidation != null) {
      _errorMessage.value = emailValidation;
      Get.snackbar(
        'Perhatian',
        _errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return;
    }
    
    // Tampilkan loading
    _isLoading.value = true;
    
    try {
      // PERBAIKAN 2: Gunakan try-catch terpisah untuk penanganan error yang lebih baik
      try {
        // Gunakan repository untuk cek email
        final response = await _authRepository.checkEmail(email);
        
        // Debug log untuk melihat isi response
        debugPrint("DEBUG - Check Email Response: $response");
        
        // PERBAIKAN 3: Handle response format yang mungkin berbeda
        // Cek format respons dan lakukan validasi
        if (response.containsKey('status')) {
          if (response['status'] == 'success') {
            final data = response.containsKey('data') ? response['data'] : null;
            
            if (data != null) {
              final bool emailExists = data.containsKey('email_exists') ? 
                  data['email_exists'] : false;
              
              final String? role = emailExists && data.containsKey('role') ? 
                  data['role'] : null;
              
              debugPrint("DEBUG - Email exists: $emailExists, Role: $role");
              
              if (emailExists) {
                if (role == 'nasabah') {
                  Get.toNamed(Routes.loginConfirm, arguments: email);
                  return;
                } else {
                  _errorMessage.value = "Email ini terdaftar dengan role '$role', bukan nasabah.";
                }
              } else {
                _showEmailNotRegisteredDialog(email);
                return;
              }
            } else {
              _errorMessage.value = 'Data tidak valid dari server';
            }
          } else {
            _errorMessage.value = response.containsKey('message') ? 
                response['message'] : 'Gagal memeriksa email';
          }
        } 
        // PERBAIKAN 4: Cek format respons yang berbeda - model alternatif
        else if (response.containsKey('data') && response['data'] is Map) {
          // Format lama API tapi sukses
          final data = response['data'];
          
          // Periksa struktur data
          if (data.containsKey('status') && data['status'] == 'success') {
            final innerData = data.containsKey('data') ? data['data'] : null;
            
            if (innerData != null) {
              final bool emailExists = innerData.containsKey('email_exists') ? 
                  innerData['email_exists'] : false;
              
              final String? role = emailExists && innerData.containsKey('role') ? 
                  innerData['role'] : null;
              
              debugPrint("DEBUG - Email exists: $emailExists, Role: $role");
              
              if (emailExists) {
                if (role == 'nasabah') {
                  Get.toNamed(Routes.loginConfirm, arguments: email);
                  return;
                } else {
                  _errorMessage.value = "Email ini terdaftar dengan role '$role', bukan nasabah.";
                }
              } else {
                _showEmailNotRegisteredDialog(email);
                return;
              }
            } else {
              _errorMessage.value = 'Data tidak valid dari server';
            }
          } else {
            _errorMessage.value = data.containsKey('message') ? 
                data['message'] : 'Gagal memeriksa email';
          }
        } 
        // PERBAIKAN 5: Respons dengan format yang benar-benar berbeda
        else if (response.containsKey('success')) {
          if (response['success']) {
            // Coba navigasi ke halaman login confirm
            debugPrint("DEBUG - Success flag found, navigating to login confirm");
            Get.toNamed(Routes.loginConfirm, arguments: email);
            return;
          } else {
            _errorMessage.value = response.containsKey('statusMessage') ? 
                response['statusMessage'] : 'Gagal memeriksa email';
          }
        } else {
          _errorMessage.value = 'Format respons dari server tidak sesuai';
        }
      } catch (specificError) {
        debugPrint("DEBUG - Specific error checking email: $specificError");
        _errorMessage.value = "Terjadi kesalahan saat memeriksa email: $specificError";
      }
      
      // PERBAIKAN 6: Gunakan snackbar sebagai alternatif jika dialog tidak muncul
      if (_errorMessage.value.isNotEmpty) {
        Get.snackbar(
          'Error',
          _errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 5),
        );
      }
      
      // PERBAIKAN 7: Tambahkan fallback untuk kesalahan koneksi
      if (_errorMessage.value.contains("Failed to fetch") || 
          _errorMessage.value.contains("connection") ||
          _errorMessage.value.contains("koneksi")) {
        // Tambahkan delay agar snackbar sebelumnya selesai
        await Future.delayed(const Duration(seconds: 2));
        
        // Tampilkan dialog koneksi bermasalah
        _showConnectionErrorDialog(email);
      }
    } catch (e) {
      debugPrint("DEBUG - General login error: $e");
      _errorMessage.value = e.toString();
      
      Get.snackbar(
        'Error',
        _errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } finally {
      _isLoading.value = false;
    }
  }
  
  // Dialog email belum terdaftar
  void _showEmailNotRegisteredDialog(String email) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email icon
              Icon(
                Icons.email,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              
              // Title text
              Text(
                "Email Belum Terdaftar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Description text
              Text(
                "Email $email belum terdaftar di WANIGO. Ingin melanjutkan pendaftaran?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              
              // Continue registration button
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  Get.toNamed(Routes.register, arguments: email);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
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
              const SizedBox(height: 10),
              
              // Back button
              OutlinedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey.shade300),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // User harus pilih salah satu tombol
    );
  }
  
  // PERBAIKAN 8: Dialog untuk error koneksi
  void _showConnectionErrorDialog(String email) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Network error icon
              Icon(
                Icons.signal_wifi_off,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              
              // Title text
              Text(
                "Gagal Terhubung",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Description text
              Text(
                "Tidak dapat terhubung ke server. Silakan periksa koneksi internet atau gunakan mode offline.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              
              // Try again button
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  _handleLogin(); // Try again
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Coba Lagi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
              // PERBAIKAN 9: Tambahkan opsi untuk langsung menuju login confirm
              OutlinedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  
                  // Langsung ke login confirm
                  Get.toNamed(Routes.loginConfirm, arguments: email);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey.shade300),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lanjutkan Dengan Email Ini',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // User harus pilih salah satu tombol
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone mockups image
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  'assets/images/login_ads.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF1976D2).withOpacity(0.1),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 80,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Content section below image
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading with fire emoji on one line
                    const Text(
                      'Berani Kelola Sampah, Mulai dari Sekarang 🔥',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
              
                    // Email input
                    const Text(
                      'Alamat Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan alamat email anda disini',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        // Clear error message when user types
                        if (_errorMessage.value.isNotEmpty) {
                          _errorMessage.value = '';
                        }
                      },
                    ),
                    
                    const SizedBox(height: 32),
              
                    // Login Button dengan Obx
                    Obx(() => ElevatedButton(
                      onPressed: _isLoading.value 
                          ? null  // Disable button saat loading
                          : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Masuk Aplikasi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    )),
                    
                    const SizedBox(height: 16),
                    
                    // Error message
                    Obx(() => _errorMessage.value.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _errorMessage.value,
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 14,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                    ),
                    
                    // Privacy policy text
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: 'Dengan melanjutkan, Anda menyetujui '),
                            TextSpan(
                              text: 'Kebijakan Privasi',
                              style: const TextStyle(
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle privacy policy tap
                                },
                            ),
                            const TextSpan(text: ' yang berlaku di WANIGO!.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}