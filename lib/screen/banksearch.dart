// lib/screen/banksearch.dart
import 'package:flutter/material.dart';
import 'package:wanigo_listbank/screen/bankoverview.dart'; // Import the overview screen

class BankSearchScreen extends StatefulWidget {
  const BankSearchScreen({Key? key}) : super(key: key);

  @override
  _BankSearchScreenState createState() => _BankSearchScreenState();
}

class _BankSearchScreenState extends State<BankSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "Terdekat"; // Default selected filter
  late List<BankSampah> allBankSampah; // All waste banks
  late List<BankSampah> filteredBankSampah; // Filtered waste banks
  
  // Define filter categories
  final List<String> filterCategories = [
    "Terdekat", 
    "Semua", 
    "Sampah Basah", 
    "Sampah Kering"
  ];
  
  // Define colors
  final Color primaryBlue = const Color(0xFF0A5AEB);
  final Color textBlack = Colors.black;
  final Color buttonTextWhite = Colors.white;
  final Color btnBlue = const Color(0xFF0A5AEB);
  final Color btnRed = const Color(0xFFFF5C5C);
  
  @override
  void initState() {
    super.initState();
    
    // Sample data for waste banks with various distances and waste types
    allBankSampah = [
      BankSampah(
        name: "Bank Sampah Kawan Surabaya",
        distance: 0.5,
        status: "Aktif",
        hours: "10.00 - 22.00",
        address: "Jl. Jojoran Baru III No.30 Mojo, Kec. Gubeng, Surabaya...",
        wasteType: "dry", // Dry waste
        isRegistered: true,
      ),
      BankSampah(
        name: "Bank Sampah Eco Green",
        distance: 0.8,
        status: "Aktif",
        hours: "09.00 - 17.00",
        address: "Jl. Raya Darmo 56, Kec. Wonokromo, Surabaya...",
        wasteType: "wet", // Wet waste
        isRegistered: false,
      ),
      BankSampah(
        name: "Bank Sampah Bersatu",
        distance: 1.2,
        status: "Aktif",
        hours: "08.00 - 20.00",
        address: "Jl. Diponegoro 123, Kec. Tegalsari, Surabaya...",
        wasteType: "all", // All types
        isRegistered: false,
      ),
      BankSampah(
        name: "Bank Sampah Lingkungan Hijau",
        distance: 1.5,
        status: "Aktif",
        hours: "08.00 - 16.00",
        address: "Jl. Kusuma Bangsa 45, Kec. Genteng, Surabaya...",
        wasteType: "dry", // Dry waste
        isRegistered: false,
      ),
      BankSampah(
        name: "Bank Sampah Organik Plus",
        distance: 0.7,
        status: "Aktif",
        hours: "09.30 - 18.00",
        address: "Jl. Mayjend Sungkono 89, Kec. Dukuh Pakis, Surabaya...",
        wasteType: "wet", // Wet waste
        isRegistered: true,
      ),
      BankSampah(
        name: "Bank Sampah Daur Ulang",
        distance: 1.8,
        status: "Aktif",
        hours: "10.00 - 19.00",
        address: "Jl. Rungkut Industri 76, Kec. Rungkut, Surabaya...",
        wasteType: "all", // All types
        isRegistered: false,
      ),
    ];
    
    // Initialize filtered list with the default filter (Terdekat)
    applyFilter(_selectedFilter);
  }

  // Apply filter based on selected category
  void applyFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      
      switch (filter) {
        case "Terdekat":
          // Filter banks within 0.5-1km range
          filteredBankSampah = allBankSampah
              .where((bank) => bank.distance >= 0.5 && bank.distance <= 1.0)
              .toList();
          break;
        case "Semua":
          // Show all banks
          filteredBankSampah = List.from(allBankSampah);
          break;
        case "Sampah Basah":
          // Show only banks that accept wet waste (wet or all)
          filteredBankSampah = allBankSampah
              .where((bank) => bank.wasteType == "wet" || bank.wasteType == "all")
              .toList();
          break;
        case "Sampah Kering":
          // Show only banks that accept dry waste (dry or all)
          filteredBankSampah = allBankSampah
              .where((bank) => bank.wasteType == "dry" || bank.wasteType == "all")
              .toList();
          break;
        default:
          filteredBankSampah = List.from(allBankSampah);
      }
      
      // Sort by distance
      filteredBankSampah.sort((a, b) => a.distance.compareTo(b.distance));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          _buildScrollableFilterTabs(),
          _buildResultCount(),
          Expanded(
            child: _buildBankList(),
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
              Icon(
                Icons.recycling, 
                color: primaryBlue,
                size: 24,
              ),
              SizedBox(width: 4),
              Text(
                "WANIGO!",
                style: TextStyle(
                  color: primaryBlue,
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Ketikkan nama bank sampah disini',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) {
                  // Apply search filter
                  if (value.isNotEmpty) {
                    setState(() {
                      filteredBankSampah = filteredBankSampah
                          .where((bank) => bank.name.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  } else {
                    // Reset to current filter if search is cleared
                    applyFilter(_selectedFilter);
                  }
                },
              ),
            ),
          ),
          
          // Filter button
          Container(
            margin: const EdgeInsets.only(left: 12),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Icon(
                Icons.tune,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableFilterTabs() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filterCategories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < filterCategories.length - 1 ? 8 : 0),
            child: _buildFilterTab(filterCategories[index]),
          );
        },
      ),
    );
  }

  Widget _buildFilterTab(String title) {
    final bool isSelected = _selectedFilter == title;
    
    return GestureDetector(
      onTap: () {
        // Apply the corresponding filter when tab is tapped
        applyFilter(title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.transparent,
          border: Border.all(
            color: isSelected ? primaryBlue : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildResultCount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        "Menampilkan ${filteredBankSampah.length} bank sampah",
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildBankList() {
    return filteredBankSampah.isEmpty 
      ? Center(
          child: Text(
            "Tidak ada bank sampah yang sesuai dengan filter",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        )
      : ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: filteredBankSampah.length,
          separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          itemBuilder: (context, index) {
            return BankSampahCard(
              bankSampah: filteredBankSampah[index],
              buttonTextWhite: buttonTextWhite,
              btnBlue: btnBlue,
              btnRed: btnRed,
            );
          },
        );
  }
}

// The BankSampah class is defined at the file level so it can be exported
class BankSampah {
  final String name;
  final double distance;
  final String status;
  final String hours;
  final String address;
  final String wasteType;
  bool isRegistered; // Changed from final to allow updates

  BankSampah({
    required this.name,
    required this.distance,
    required this.status,
    required this.hours,
    required this.address,
    required this.wasteType,
    required this.isRegistered,
  });
}

class BankSampahCard extends StatelessWidget {
  final BankSampah bankSampah;
  final Color buttonTextWhite;
  final Color btnBlue;
  final Color btnRed;

  const BankSampahCard({
    Key? key,
    required this.bankSampah,
    required this.buttonTextWhite,
    required this.btnBlue,
    required this.btnRed,
  }) : super(key: key);

  // Helper method to get the waste type display text
  String getWasteTypeText() {
    switch (bankSampah.wasteType) {
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
    return GestureDetector(
      onTap: () {
        // Navigate to the detail screen when a bank is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BankSampahDetailScreen(bankSampah: bankSampah),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bankSampah.isRegistered ? Color(0xFFECF4FF) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankSampah.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${bankSampah.distance}km dari lokasimu',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
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
                    bankSampah.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  bankSampah.hours,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              bankSampah.address,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getWasteTypeText(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle registration button action
                  },
                  child: Text(
                    bankSampah.isRegistered ? 'Sudah Terdaftar' : 'Tidak Terdaftar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: buttonTextWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bankSampah.isRegistered ? btnBlue : btnRed,
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