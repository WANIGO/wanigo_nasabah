// lib/screen/bankoverview.dart
import 'package:flutter/material.dart';
import 'banksearch.dart'; // Import to get access to BankSampah class

class BankSampahDetailScreen extends StatefulWidget {
  final BankSampah bankSampah;

  const BankSampahDetailScreen({
    Key? key,
    required this.bankSampah,
  }) : super(key: key);

  @override
  _BankSampahDetailScreenState createState() => _BankSampahDetailScreenState();
}

class _BankSampahDetailScreenState extends State<BankSampahDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedWasteType = "Sampah Kering"; // Default selected waste type
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildBody(),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        // Background image placeholder (to be replaced with actual image)
        Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[300], // Placeholder color
          child: Center(
            child: Text(
              "Image Placeholder",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
        
        // Back button and safe area
        SafeArea(
          child: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        
        // Address and title container at the bottom of the image
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bankSampah.address,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.bankSampah.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBar() {
    final Color primaryBlue = const Color(0xFF0A5AEB);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Status pill
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Buka",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          
          Spacer(),
          
          // Customer count
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryBlue, size: 20),
                SizedBox(width: 4),
                Text(
                  "125 nasabah",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Separator
          Container(
            height: 20,
            width: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
          
          // Waste collected
          Row(
            children: [
              Icon(Icons.recycling, color: primaryBlue, size: 20),
              SizedBox(width: 4),
              Text(
                "10+ ton sampah",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final Color primaryBlue = const Color(0xFF0A5AEB);
    
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: primaryBlue,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: primaryBlue,
        indicatorWeight: 3,
        tabs: [
          Tab(text: "Informasi Umum"),
          Tab(text: "Katalog Sampah"),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildStatusBar(),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildGeneralInfoTab(),
              _buildCatalogTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About the waste bank
          _buildSectionTitle("Tentang Bank Sampah"),
          SizedBox(height: 8),
          Text(
            "Bank Sampah ${widget.bankSampah.name} adalah tempat penampungan sampah yang mengutamakan pengelolaan sampah kering secara efektif. Kami mengajak masyarakat untuk memilah sampah dari rumah dan menyetorkannya secara rutin untuk menciptakan lingkungan yang lebih bersih dan sehat.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Bank Sampah ${widget.bankSampah.name} adalah tempat penampungan sampah yang mengutamakan pengelolaan sampah kering secara efektif. Kami mengajak masyarakat untuk memilah sampah dari rumah dan menyetorkannya secara rutin untuk menciptakan lingkungan yang lebih bersih dan sehat.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24),
          
          // Contact information
          _buildSectionTitle("Data Kontak Bank Sampah"),
          SizedBox(height: 12),
          _buildContactItem(Icons.phone, "+62 83192925747"),
          SizedBox(height: 8),
          _buildContactItem(Icons.email, "kawan@gmail.com"),
          SizedBox(height: 16),
          
          // Waste type information
          _buildWasteTypeInfo(),
          SizedBox(height: 24),
          
          // Schedules
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Operational schedule
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal Operasional",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blue, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "10:00 - 21:00 WIB",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Senin - Jumat",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Collection schedule
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal Setoran Sampah",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blue, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "10:00 WIB",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Setiap bulan",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Add to calendar button
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Tambahkan Jadwal Setoran ke Kalendar",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          
          // Location map
          _buildSectionTitle("Lokasi Bank Sampah"),
          SizedBox(height: 12),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            // Map placeholder (to be replaced with actual map)
            child: Center(
              child: Text("Map Placeholder"),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCatalogTab() {
    final Color primaryBlue = const Color(0xFF0A5AEB);
    
    // Create mock data for waste catalog
    List<Map<String, dynamic>> wasteItems = List.generate(
      7,
      (index) => {
        "name": "Nama Item Sampah",
        "price": "Rp.99.999",
      },
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Daftar Jenis Sampah yang Diterima",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        
        // Waste type toggle buttons
        Row(
          children: [
            Expanded(
              child: _buildWasteTypeToggle("Sampah Kering", primaryBlue),
            ),
            Expanded(
              child: _buildWasteTypeToggle("Sampah Basah", primaryBlue),
            ),
          ],
        ),
        
        // Table header
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                "Harga Item/Kg",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        
        // Item list
        Expanded(
          child: ListView.separated(
            itemCount: wasteItems.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        wasteItems[index]['name'],
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      wasteItems[index]['price'],
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        
        // Button at bottom is in the main bottom button area
      ],
    );
  }

  Widget _buildWasteTypeToggle(String title, Color primaryBlue) {
    final bool isSelected = _selectedWasteType == title;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedWasteType = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.grey[200],
          border: Border.all(color: isSelected ? primaryBlue : Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildWasteTypeInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              getWasteTypeText(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String getWasteTypeText() {
    switch (widget.bankSampah.wasteType) {
      case 'dry':
        return "Bank sampah ini hanya menerima sampah kering saja!";
      case 'wet':
        return "Bank sampah ini hanya menerima sampah basah saja!";
      case 'all':
        return "Bank sampah ini menerima semua jenis sampah!";
      default:
        return "Jenis sampah tidak teridentifikasi";
    }
  }

  Widget _buildBottomButton() {
    final Color primaryBlue = const Color(0xFF0A5AEB);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          if (!widget.bankSampah.isRegistered) {
            // Show success dialog for registration
            _showRegistrationSuccessDialog();
          } else {
            // Handle create waste deposit
            // (implementation depends on your app's requirements)
          }
        },
        child: Text(
          widget.bankSampah.isRegistered ? "Buat Setoran Sampah" : "Gabung Jadi Nasabah",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Show success dialog when registration completes
  void _showRegistrationSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
                SizedBox(height: 16),
                
                // Title
                Text(
                  "Berhasil Terdaftar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                
                // Message
                Text(
                  "Selamat! Anda telah berhasil terdaftar sebagai nasabah bank sampah. Sekarang Anda dapat mulai menyetor sampah",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                
                // Close button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Update registration status
                      setState(() {
                        widget.bankSampah.isRegistered = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Kembali",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
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
}