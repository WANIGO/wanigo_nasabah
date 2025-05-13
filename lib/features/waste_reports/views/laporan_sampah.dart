import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/features/waste_reports/views/penjualan_sampah_tab.dart';
import 'package:wanigo_nasabah/features/waste_reports/views/tonase_sampah_tab.dart';
import 'package:wanigo_nasabah/widgets/global_app_bar.dart';

class LaporanSampah extends StatefulWidget {
  const LaporanSampah({super.key});

  @override
  State<LaporanSampah> createState() => _LaporanSampahState();
}

class _LaporanSampahState extends State<LaporanSampah> {
  final List<Map<String, String>> bankSampahList = [
    {
      'name': 'Bank Sampah Kawan',
      'address': 'Jl Jojoran Baru III, No 30 , Kelurahan Mojo',
    },
    {
      'name': 'Bank Sampah Harapan',
      'address': 'Jl Menur No 12, Kelurahan Gubeng',
    },
    {
      'name': 'Bank Sampah Hijau',
      'address': 'Jl Kalpataru No 8, Kelurahan Wonokromo',
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const GlobalAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Laporan Sampah',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Menyajikan laporan data hasil setoran sampah untuk keseluruhan bank sampah terdaftar',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pilih Bank Sampah untuk disajikan data:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () => _showDropdownDialog(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bankSampahList[selectedIndex]['name']!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bankSampahList[selectedIndex]['address']!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.blue,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                tabs: [
                  Tab(text: 'Tonase Sampah'),
                  Tab(text: 'Penjualan Sampah'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    TonaseSampahTab(),
                    PenjualanSampahTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: bankSampahList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(bankSampahList[index]['name']!),
              subtitle: Text(bankSampahList[index]['address']!),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
