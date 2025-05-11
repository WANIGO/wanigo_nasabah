import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;
  final String bankType;

  const ProfileScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phone,
    required this.bankType,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  // Check if all fields are filled to enable button
  bool get _areAllFieldsFilled => 
    _bankNameController.text.isNotEmpty && 
    _phoneController.text.isNotEmpty && 
    _emailController.text.isNotEmpty;
  
  @override
  void initState() {
    super.initState();
    // Don't pre-fill the fields automatically
  }
  
  @override
  void dispose() {
    _bankNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use setState when text fields change to update button color
    _bankNameController.addListener(() {
      setState(() {});
    });
    _phoneController.addListener(() {
      setState(() {});
    });
    _emailController.addListener(() {
      setState(() {});
    });
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
                  color: Color(0xFF1E88E5),
                ),
                Text(
                  "WANIGO!",
                  style: TextStyle(
                    color: Color(0xFF1E88E5),
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator with dot - matching the reference image
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 1/3, // 1 of 3 pages
                        backgroundColor: Colors.blue.shade100,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0A5AEB)),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                // Dot at the end of colored part
                Positioned(
                  left: MediaQuery.of(context).size.width * (1/3) - 40, // Adjust for padding
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF0A5AEB), width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Text(
                        'Profil Bank Sampah',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '1 dari 3',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Bank name field
                  Text(
                    'Nama Lengkap Usaha Bank Sampah',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  TextField(
                    controller: _bankNameController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama bank sampah',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
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
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Phone field
                  Text(
                    'Nomor Telepon Usaha',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nomor telepon anda',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
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
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Use account phone link
                  GestureDetector(
                    onTap: () {
                      // Fill phone field when clicked
                      setState(() {
                        _phoneController.text = widget.phone;
                      });
                    },
                    child: Text(
                      'Klik disini untuk gunakan nomor telepon akun',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0A5AEB),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF0A5AEB),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Email field
                  Text(
                    'Alamat Email Usaha',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat email usaha disini',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
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
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Use account email link - no bottom border
                  GestureDetector(
                    onTap: () {
                      // Fill email field when clicked
                      setState(() {
                        _emailController.text = widget.email;
                      });
                    },
                    child: Text(
                      'Klik disini untuk gunakan alamat email akun',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0A5AEB),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF0A5AEB),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Continue button
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _validateAndContinue,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _areAllFieldsFilled 
                    ? const Color(0xFF0A5AEB) 
                    : const Color(0xFFADC8F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _validateAndContinue() {
    // Validate all fields
    if (_bankNameController.text.isEmpty) {
      _showErrorSnackBar('Nama bank sampah harus diisi');
      return;
    }
    
    if (_phoneController.text.isEmpty) {
      _showErrorSnackBar('Nomor telepon harus diisi');
      return;
    }
    
    if (_emailController.text.isEmpty) {
      _showErrorSnackBar('Alamat email harus diisi');
      return;
    }
    
    // All validations passed, proceed to next page
    print('Bank Name: ${_bankNameController.text}');
    print('Phone: ${_phoneController.text}');
    print('Email: ${_emailController.text}');
    print('Bank Type: ${widget.bankType}');
    
    // TODO: Navigate to the next profile page
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}