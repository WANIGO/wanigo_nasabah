// listbank.dart (updated with navigation)
import 'package:flutter/material.dart';
import 'package:wanigo_listbank/screen/banksearch.dart'; // Import the bank search screen

class WasteBankScreen extends StatefulWidget {
  const WasteBankScreen({Key? key}) : super(key: key);

  @override
  _WasteBankScreenState createState() => _WasteBankScreenState();
}

class _WasteBankScreenState extends State<WasteBankScreen> {
  // State: 0 = no banks registered, 1 = at least one bank registered
  int _currentState = 0; // Default to no banks registered
  late List<WasteBank> wasteBanks;
  
  // Define colors
  final Color primaryBlue = const Color(0xFF0A5AEB);
  final Color textBlack = Colors.black;
  final Color buttonTextWhite = Colors.white; // #FFFFFF
  
  @override
  void initState() {
    super.initState();
    
    // Sample data for when banks are registered (state = 1)
    // Updated with three different wasteType examples
    wasteBanks = [
      WasteBank(
        name: "Bank Sampah Kawan Surabaya",
        distance: 0.5,
        status: "Aktif",
        hours: "10.00 - 22.00",
        address: "Jl. Jojoran Baru III No.30 Mojo, Kec. Gubeng, Surabaya...",
        wasteType: "dry", // Only accepts dry waste
        isRegistered: true,
      ),
      WasteBank(
        name: "Bank Sampah Eco Green",
        distance: 1.2,
        status: "Aktif",
        hours: "09.00 - 17.00",
        address: "Jl. Raya Darmo 56, Kec. Wonokromo, Surabaya...",
        wasteType: "wet", // Only accepts wet waste
        isRegistered: true,
      ),
      WasteBank(
        name: "Bank Sampah Bersatu",
        distance: 0.8,
        status: "Aktif",
        hours: "08.00 - 20.00",
        address: "Jl. Diponegoro 123, Kec. Tegalsari, Surabaya...",
        wasteType: "all", // Accepts all types of waste
        isRegistered: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _currentState == 0 ? buildEmptyState() : buildPopulatedState();
  }

  Widget buildPopulatedState() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: wasteBanks.length,
              itemBuilder: (context, index) {
                return WasteBankCard(
                  wasteBank: wasteBanks[index],
                  primaryBlue: primaryBlue,
                  textBlack: textBlack,
                  buttonTextWhite: buttonTextWhite,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the bank search screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BankSearchScreen()),
              );
            },
            child: Text(
              'Tambah Bank Sampah Baru',
              style: TextStyle(
                color: buttonTextWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate positions based on screen height
                final double screenHeight = constraints.maxHeight;
                
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Content positioned higher on screen
                    Positioned(
                      top: screenHeight * 0.05, // Move content higher (5% from top)
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/bank_icon.png',
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(height: 12), // Reduced space between icon and title
                          Text(
                            'Tidak Terdaftar di Bank Sampah Manapun',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textBlack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8), // Reduced from 16 to 8 to bring description closer
                          // Made description text wider by reducing horizontal padding
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              'Saat ini, kamu belum terdaftar sebagai nasabah di bank sampah manapun. Yuk, daftarkan dirimu di bank sampah terdekat untuk mulai menabung dan mengelola sampah dengan mudah!',
                              style: TextStyle(
                                fontSize: 14,
                                color: textBlack.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Button positioned 1/3 from bottom + 10px lower
                    Positioned(
                      // Adjusted to move 10px lower
                      bottom: (screenHeight / 3) - 10, 
                      left: 40,
                      right: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the bank search screen when button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankSearchScreen()),
                          );
                        },
                        child: Text(
                          'Cari Bank Sampah',
                          style: TextStyle(
                            color: buttonTextWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.chevron_left, color: textBlack.withOpacity(0.8)),
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
              SizedBox(width: 4),
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Sampah Saya',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textBlack,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Menampilkan daftar bank sampah yang terdaftar sebagai tempat Anda menabung sampah.',
            style: TextStyle(
              fontSize: 16,
              color: textBlack.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class WasteBank {
  final String name;
  final double distance;
  final String status;
  final String hours;
  final String address;
  final String wasteType;
  final bool isRegistered;

  WasteBank({
    required this.name,
    required this.distance,
    required this.status,
    required this.hours,
    required this.address,
    required this.wasteType,
    required this.isRegistered,
  });
}

class WasteBankCard extends StatelessWidget {
  final WasteBank wasteBank;
  final Color primaryBlue;
  final Color textBlack;
  final Color buttonTextWhite;

  const WasteBankCard({
    Key? key, 
    required this.wasteBank,
    required this.primaryBlue,
    required this.textBlack,
    required this.buttonTextWhite,
  }) : super(key: key);

  // Helper method to get the waste type display text
  String getWasteTypeText() {
    switch (wasteBank.wasteType) {
      case 'dry':
        return 'Hanya menerima sampah kering';
      case 'wet':
        return 'Hanya menerima sampah basah';
      case 'all':
        return 'Menerima semua jenis sampah';
      default:
        return 'Jenis sampah tidak teridentifikasi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wasteBank.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textBlack,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${wasteBank.distance}km dari lokasimu',
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.6),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    wasteBank.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  wasteBank.hours,
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              wasteBank.address,
              style: TextStyle(
                fontSize: 12,
                color: textBlack.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display appropriate text based on waste type
                Text(
                  getWasteTypeText(),
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.8),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle registration status
                  },
                  child: Text(
                    'Sudah Terdaftar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: buttonTextWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}