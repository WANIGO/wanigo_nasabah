import 'package:flutter/material.dart';
import '../data/models/profile_model.dart';
import '../data/models/tabungan_model.dart';
import '../data/models/calendar_schedule_model.dart';
import '../data/models/setoran_sampah_model.dart';
import '../widgets/profile_card.dart';
import '../widgets/tabungan_saldo.dart';
import '../widgets/calendar_card.dart';
import '../widgets/setoran_sampah_card.dart';

class NasabahHomeScreen extends StatelessWidget {
  const NasabahHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              profile: ProfileModel(
                userName: 'Adhitya Pratama',
                points: 0,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.blue.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TabunganCard(
                tabungan: TabunganModel(
                  saldo: 24000.00,
                  beratSampah: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            CalendarProfile(
              schedule: CalendarScheduleModel(
                day: 18,
                month: 'Sep',
                weekday: 'Selasa',
                message:
                'Jadwal Pemilahan/Penyetoran Sampah Anda Belum Dibuat.',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Fitur Aplikasi WANIGO!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureIcons(),
            const SizedBox(height: 24),
            const Text(
              'Setoran Sampah Terkini',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SetoranSampahCard(
              setoran: SetoranSampahModel(
                title: 'Buat Rencana Setoran',
                description:
                'Mulai ajukan setoran sampah Anda & berkontribusi menjaga lingkungan',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 16,
      title: const Text(
        'WANIGO!',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),

      actions: const [
        Icon(Icons.notifications_none, color: Colors.black),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildFeatureIcons() {
    final features = [
      {'label': 'Edukasi', 'icon': Icons.menu_book},
      {'label': 'Laporan', 'icon': Icons.receipt_long},
      {'label': 'Juara', 'icon': Icons.emoji_events},
      {'label': 'Misi', 'icon': Icons.track_changes},
      {'label': 'Lainnya', 'icon': Icons.grid_view},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: features.map((f) {
        return Column(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.shade50,
              child: Icon(f['icon'] as IconData, color: Colors.blue),
            ),
            const SizedBox(height: 4),
            Text(
              f['label'] as String,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      currentIndex: 2,
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Beranda'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_bag, color: Colors.white),
          ),
          label: 'Setoran',
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: 'Pesan'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
