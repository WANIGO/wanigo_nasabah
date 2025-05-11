import 'package:flutter/material.dart';
import 'package:wanigo_mitra/screen/bank_type.dart'; // Import the bank type screen

class BankStatusScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;

  const BankStatusScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<BankStatusScreen> createState() => _BankStatusScreenState();
}

class _BankStatusScreenState extends State<BankStatusScreen> {
  // Selected status option
  String? _selectedStatus;
  final TextEditingController _accessCodeController = TextEditingController();
  bool _showAccessCodeError = false;

  @override
  void initState() {
    super.initState();
    _accessCodeController.addListener(() {
      // Reset error when user types
      if (_showAccessCodeError) {
        setState(() {
          _showAccessCodeError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _accessCodeController.dispose();
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Status Bank Sampah',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Subtitle
                  Text(
                    'Pilih status bank sampah untuk melanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Question
                  Text(
                    'Apakah bank sampah anda sudah pernah terdaftar di aplikasi WANIGO! sebelumnya?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Option buttons
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedStatus = 'Iya, sudah';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _selectedStatus == 'Iya, sudah' 
                                    ? Color(0xFF0A5AEB)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: _selectedStatus == 'Iya, sudah'
                                    ? Border.all(
                                        color: Color(0x266B39F4), // #6B39F426 (with alpha)
                                        width: 2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Iya, sudah',
                                style: TextStyle(
                                  color: _selectedStatus == 'Iya, sudah'
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedStatus = 'Tidak, belum';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _selectedStatus == 'Tidak, belum'
                                    ? Color(0xFF0A5AEB)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: _selectedStatus == 'Tidak, belum'
                                    ? Border.all(
                                        color: Color(0x266B39F4), // #6B39F426 (with alpha)
                                        width: 2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Tidak, Belum',
                                style: TextStyle(
                                  color: _selectedStatus == 'Tidak, belum'
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Access code input field - only shown if "Iya, sudah" is selected
                  if (_selectedStatus == 'Iya, sudah') ...[
                    SizedBox(height: 24),
                    
                    Text(
                      'Masukkan kode akses bank sampah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    TextField(
                      controller: _accessCodeController,
                      decoration: InputDecoration(
                        hintText: 'BANKSAMPAHKAWANSBY12',
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
                          borderSide: BorderSide(color: _showAccessCodeError ? Colors.red : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _showAccessCodeError ? Colors.red : Color(0xFF0A5AEB)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 8),
                    
                    if (_showAccessCodeError)
                      Text(
                        'Perhatikan! Kode bank sampah tidak ditemukan!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    
                    if (!_showAccessCodeError)
                      Text(
                        'Note: dengan ini anda akan terdaftar sebagai petugas pada bank sampah tersebut',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
          
          // Continue button positioned higher
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40), // More bottom padding
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (_selectedStatus != null && 
                          (_selectedStatus == 'Tidak, belum' || 
                           (_selectedStatus == 'Iya, sudah' && _accessCodeController.text.isNotEmpty)))
                  ? () {
                      // Validate code if "Iya, sudah" is selected
                      if (_selectedStatus == 'Iya, sudah') {
                        // Mock validation - consider this a "known code"
                        final knownCode = "BANKSAMPAHKAWANSBY12";
                        
                        if (_accessCodeController.text != knownCode) {
                          setState(() {
                            _showAccessCodeError = true;
                          });
                          return; // Don't navigate if code is invalid
                        }
                        
                        print('Access code valid: ${_accessCodeController.text}');
                      }
                      
                      // If code is valid or "Tidak, belum" was selected, navigate
                      print('Selected status: $_selectedStatus');
                      
                      // Navigate based on selection
                      if (_selectedStatus == 'Tidak, belum') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BankTypeScreen(
                              email: widget.email,
                              name: widget.name,
                              phone: widget.phone,
                            ),
                          ),
                        );
                      } else {
                        // Handle navigation for "Iya, sudah" with valid code
                        // Add navigation logic here
                      }
                    }
                  : null, // Disable button if no option selected or if code is required but empty
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF0A5AEB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: const Color(0xFF92B5FF),
                  disabledForegroundColor: Colors.white,
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
}