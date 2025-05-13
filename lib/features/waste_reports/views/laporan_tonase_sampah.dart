import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/widgets/global_app_bar.dart';

class LaporanTonaseSampah extends StatelessWidget {
  const LaporanTonaseSampah({super.key});

  Widget _buildTanggalSection(String tanggal, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tanggal,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  Widget _buildTonaseItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KWNA000001',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Total 10 item sampah'),
            ],
          ),
          const Text(
            '+100Kilogram',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Riwayat Tonase Sampah',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildTanggalSection('Sabtu, 1 Maret 2025', [
              _buildTonaseItem(),
              _buildTonaseItem(),
            ]),
            _buildTanggalSection('Jumat, 28 Februari 2025', [
              _buildTonaseItem(),
              _buildTonaseItem(),
            ]),
            _buildTanggalSection('Kamis, 27 Februari 2025', [
              _buildTonaseItem(),
              _buildTonaseItem(),
            ]),
          ],
        ),
      ),
    );
  }
}
