import 'package:flutter/material.dart';
import 'package:wanigo_mitra/screen/mitra_step1.dart'; // Import the profile screen

class BankTypeScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;

  const BankTypeScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<BankTypeScreen> createState() => _BankTypeScreenState();
}

class _BankTypeScreenState extends State<BankTypeScreen> {
  String? _selectedType;

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
                    'Tipe Bank Sampah',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Subtitle
                  Text(
                    'Silahkan pilih salah satu dari 2 pilihan berikut',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Bank Sampah Unit option
                  _buildOptionCard(
                    title: 'Bank Sampah Unit',
                    description: 'Diperuntukkan pengelolaan sampah di lingkungan Rumah Tangga',
                    type: 'unit',
                    iconPath: 'assets/house.png',
                    onTap: () {
                      // Navigate to the ProfileScreen with type 'unit'
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            email: widget.email,
                            name: widget.name,
                            phone: widget.phone,
                            bankType: 'unit',
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Bank Sampah Induk option
                  _buildOptionCard(
                    title: 'Bank Sampah Induk',
                    description: 'Diperuntukkan area yang lebih luas yaitu beberapa bank sampah unit',
                    type: 'induk',
                    iconPath: 'assets/corp.png',
                    onTap: () {
                      // Navigate to the ProfileScreen with type 'induk'
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            email: widget.email,
                            name: widget.name,
                            phone: widget.phone,
                            bankType: 'induk',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptionCard({
    required String title,
    required String description,
    required String type,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    bool isSelected = _selectedType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
        // Call the provided onTap callback
        onTap();
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Color(0xFF0A5AEB) : Colors.grey.shade300,
            width: isSelected ? 2 : 0.75,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/bank_typebox.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Main Row Content
            Row(
              children: [
                // Text content taking 75% of width
                Expanded(
                  flex: 75, // 75% of the width
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 12, // 12px font size
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Empty space for icon (25% of width)
                Expanded(
                  flex: 25, // 25% of the width
                  child: Container(),
                ),
              ],
            ),

            // Icon positioned on right
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}