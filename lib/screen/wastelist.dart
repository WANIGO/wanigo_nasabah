import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wanigo_inven/screen/wasteinvform.dart';
import 'package:wanigo_inven/screen/wasteinven.dart';

class WasteItemCatalogScreen extends StatefulWidget {
  const WasteItemCatalogScreen({Key? key}) : super(key: key);

  @override
  State<WasteItemCatalogScreen> createState() => _WasteItemCatalogScreenState();
}

class _WasteItemCatalogScreenState extends State<WasteItemCatalogScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Testing state: 
  // 0 = Sampah Organik only
  // 1 = Sampah Anorganik only
  // 2 = Both
  final int _testingState = 2; // Change this value to test different states
  
  // Lists to store waste items
  final List<WasteItem> _keringItems = [];
  final List<WasteItem> _basahItems = [];

  @override
  void initState() {
    super.initState();
    
    // Set number of tabs based on testing state
    int tabCount = _testingState == 2 ? 2 : 1;
    _tabController = TabController(length: tabCount, vsync: this);
    
    // Start with the right tab selected based on testing state
    if (_testingState == 1) {
      _tabController.index = 0; // Sampah Anorganik
    } else if (_testingState == 0) {
      _tabController.index = 0; // Sampah Organik
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // Add a new waste item
  void _addWasteItem(WasteItem item) {
    setState(() {
      if (item.category == 'Sampah Anorganik') {
        _keringItems.add(item);
      } else if (item.category == 'Sampah Organik') {
        _basahItems.add(item);
      }
    });
  }
  
  // Navigate to form with the current tab as default category
  void _navigateToForm() {
    String? defaultCategory;
    
    if (_testingState == 0) {
      defaultCategory = 'Sampah Organik';
    } else if (_testingState == 1) {
      defaultCategory = 'Sampah Anorganik';
    } else {
      // For state 2 (both tabs), use the currently selected tab
      defaultCategory = _tabController.index == 0 ? 'Sampah Anorganik' : 'Sampah Organik';
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormItemSampahScreen(
          onItemAdded: _addWasteItem,
          defaultCategory: defaultCategory,
          isDropdownEnabled: _testingState == 2, // Only enable dropdown for state 2
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Setting resizeToAvoidBottomInset to false to prevent layout shifts with keyboard
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFF084BC4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.recycling, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 4),
            const Text(
              'WANIGO!',
              style: TextStyle(
                color: Color(0xFF084BC4),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Katalog Item Sampah',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kelola item sampah beserta kategorinya',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                // Check Waste Bank Inventory Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InventarisSampahScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: const Color(0xFFDEE9FD),
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFF084BC4), width: 2.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cek Inventaris Bank Sampah',
                    style: TextStyle(
                      color: Color(0xFF084BC4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Tab Bar
                _buildTabBar(),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _navigateToForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A5AEB),
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Tambah Item Sampah',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Build the tab bar based on testing state
  Widget _buildTabBar() {
    if (_testingState == 0) {
      // Sampah Organik only
      return TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF084BC4),
        labelColor: const Color(0xFF084BC4),
        unselectedLabelColor: const Color(0xFF585A6E),
        tabs: const [
          Tab(text: 'Sampah Organik'),
        ],
      );
    } else if (_testingState == 1) {
      // Sampah Anorganik only
      return TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF084BC4),
        labelColor: const Color(0xFF084BC4),
        unselectedLabelColor: const Color(0xFF585A6E),
        tabs: const [
          Tab(text: 'Sampah Anorganik'),
        ],
      );
    } else {
      // Both tabs
      return TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF084BC4),
        labelColor: const Color(0xFF084BC4),
        unselectedLabelColor: const Color(0xFF585A6E),
        tabs: const [
          Tab(text: 'Sampah Anorganik'),
          Tab(text: 'Sampah Organik'),
        ],
      );
    }
  }

  // Build the tab content based on testing state
  Widget _buildTabContent() {
    if (_testingState == 0) {
      // Sampah Organik only
      return TabBarView(
        controller: _tabController,
        children: [
          _buildTabItems(_basahItems),
        ],
      );
    } else if (_testingState == 1) {
      // Sampah Anorganik only
      return TabBarView(
        controller: _tabController,
        children: [
          _buildTabItems(_keringItems),
        ],
      );
    } else {
      // Both tabs
      return TabBarView(
        controller: _tabController,
        children: [
          _buildTabItems(_keringItems),
          _buildTabItems(_basahItems),
        ],
      );
    }
  }
  
  // Build either the empty state or the list of items
  Widget _buildTabItems(List<WasteItem> items) {
    if (items.isEmpty) {
      return _buildEmptyState();
    } else {
      return ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Item image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: item.imagePath != null
                        ? Image.file(
                            File(item.imagePath!),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            color: const Color(0xFFEFF3FD),
                            child: const Icon(
                              Icons.image,
                              color: Color(0xFF084BC4),
                              size: 32,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  // Item details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp${item.price.toStringAsFixed(0)}/kg',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A5AEB),
                            minimumSize: const Size(double.infinity, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Atur Jadwal Penjualan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Trash Bin Icon with X
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Item Sampah',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Tidak Ditemukan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Belum ada data item sampah yang ditambahkan pada katalog bank sampah anda. Mohon menambahkan data item terlebih dahulu!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}