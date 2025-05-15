import 'package:flutter/material.dart';
import 'dart:io';

class InventarisSampahScreen extends StatefulWidget {
  const InventarisSampahScreen({Key? key}) : super(key: key);

  @override
  State<InventarisSampahScreen> createState() => _InventarisSampahScreenState();
}

class _InventarisSampahScreenState extends State<InventarisSampahScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Lists to store inventory items (empty by default)
  final List<Map<String, dynamic>> _sampahKeringItems = [];
  final List<Map<String, dynamic>> _sampahBasahItems = [];

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
                  'Inventaris Sampah',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kelola inventaris sampah dengan mudahnya',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                // Tab Bar
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFF084BC4),
                  labelColor: const Color(0xFF084BC4),
                  unselectedLabelColor: const Color(0xFF585A6E),
                  tabs: const [
                    Tab(text: 'Sampah Kering'),
                    Tab(text: 'Sampah Basah'),
                  ],
                ),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Sampah Kering tab
                _buildInventaryList(_sampahKeringItems),
                // Sampah Basah tab
                _buildInventaryList(_sampahBasahItems),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInventaryList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Color(0xFF084BC4),
            ),
            SizedBox(height: 16),
            Text(
              'Belum ada data inventaris',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tambahkan item sampah terlebih dahulu',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    
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
                  child: item['image'] != null
                      ? Image.file(
                          File(item['image']),
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
                        item['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${item['quantity']} Kg',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(Update ${item['update_date']})',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Show inventory details
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A5AEB),
                          minimumSize: const Size(double.infinity, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cek Detail Inventaris',
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