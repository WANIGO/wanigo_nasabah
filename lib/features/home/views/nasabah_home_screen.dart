import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'package:wanigo_nasabah/data/models/profile_model.dart';
import 'package:wanigo_nasabah/data/models/tabungan_model.dart';
import 'package:wanigo_nasabah/data/models/calendar_schedule_model.dart';
import 'package:wanigo_nasabah/data/models/setoran_sampah_model.dart';
import 'package:wanigo_nasabah/features/home/widgets/profile_card.dart';
import 'package:wanigo_nasabah/features/home/widgets/tabungan_saldo.dart';
import 'package:wanigo_nasabah/features/home/widgets/calendar_card.dart';
import 'package:wanigo_nasabah/features/home/widgets/setoran_sampah_card.dart';

class NasabahHomeScreen extends StatefulWidget {
  const NasabahHomeScreen({super.key});

  @override
  State<NasabahHomeScreen> createState() => _NasabahHomeScreenState();
}

class _NasabahHomeScreenState extends State<NasabahHomeScreen> {
  // Current index untuk bottom navigation
  int _currentIndex = 0;

  // Method untuk mengganti halaman saat navigasi diklik
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Navigasi ke halaman yang sesuai berdasarkan index
    switch (index) {
      case 0: // Beranda - sudah di halaman ini
        break;
      case 1: // Riwayat
        Get.toNamed('/riwayat');
        break;
      case 2: // Setoran
        Get.toNamed('/setoran');
        break;
      case 3: // Pesan
        Get.toNamed('/pesan');
        break;
      case 4: // Profil
        Get.toNamed('/profil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Background layer - DCE8FF color
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 513.h,
              color: const Color(0xFFDCE8FF),
            ),
          ),
          
          // Content layer
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian atas dengan padding horizontal yang konsisten 20px
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Card - Full width
                      ProfileCard(
                        profile: ProfileModel(
                          userName: 'Adhitya Pratama',
                          points: 0,
                        ),
                      ),
                      
                      SizedBox(height: 14.h),
                      
                      // Tabungan Card - Full width
                      TabunganCard(
                        tabungan: TabunganModel(
                          saldo: 24000.00,
                          beratSampah: 12,
                        ),
                      ),
                      
                      SizedBox(height: 18.h),
                      
                      // Calendar Card - Full width
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: const Color(0xFFCACACA)),
                        ),
                        padding: EdgeInsets.all(12.r),
                        child: CalendarProfile(
                          schedule: CalendarScheduleModel(
                            day: 18,
                            month: 'Sep',
                            weekday: 'Selasa',
                            message:
                            'Jadwal Pemilahan/Penyetoran Sampah Anda Belum Dibuat.',
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
                
                // Section with white background - Features and Setoran
                Container(
                  width: double.infinity, // Full width
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.r), // Konsisten 20px padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Features Section
                        GlobalText(
                          text: 'Fitur Aplikasi WANIGO!',
                          variant: TextVariant.h5,
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        _buildFeatureIcons(),
                        
                        SizedBox(height: 32.h),
                        
                        // Setoran Section
                        GlobalText(
                          text: 'Setoran Sampah Terkini',
                          variant: TextVariant.h5,
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        SetoranSampahCard(
                          setoran: SetoranSampahModel(
                            title: 'Buat Rencana Setoran',
                            description:
                            'Mulai ajukan setoran sampah Anda & berkontribusi menjaga lingkungan',
                          ),
                        ),
                        
                        // Tambah padding ekstra untuk memastikan bg_main_bottom terlihat
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 20.r, // Konsisten 20px
      title: Image.asset(
        'assets/images/appbar_logo.png',
        height: 30.h,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading appbar_logo.png: $error');
          return Text(
            'WANIGO!',
            style: TextStyle(
              color: AppColors.blue500,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.r), // Konsisten 20px
          child: Image.asset(
            'assets/images/lonceng.png',
            width: 24.r,
            height: 24.r,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading lonceng.png: $error');
              return Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 24.r,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcons() {
    final features = [
      {'label': 'Edukasi', 'image': 'assets/images/edukasi.png', 'icon': Icons.menu_book},
      {'label': 'Laporan', 'image': 'assets/images/laporan.png', 'icon': Icons.receipt_long},
      {'label': 'Juara', 'image': 'assets/images/juara.png', 'icon': Icons.emoji_events},
      {'label': 'Misi', 'image': 'assets/images/misi.png', 'icon': Icons.track_changes},
      {'label': 'Lainnya', 'image': 'assets/images/lainnya.png', 'icon': Icons.grid_view},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: features.map((f) {
        return Column(
          children: [
            // Icon gambar diperbesar tanpa background bulat
            Image.asset(
              f['image'] as String,
              width: 48.r, // Ukuran diperbesar sesuai dengan ukuran container sebelumnya
              height: 48.r,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Error loading ${f['image']}: $error');
                return Icon(
                  f['icon'] as IconData,
                  color: AppColors.blue600,
                  size: 48.r, // Ukuran icon fallback juga diperbesar
                );
              },
            ),
            SizedBox(height: 4.h),
            GlobalText(
              text: f['label'] as String,
              variant: TextVariant.xSmallMedium,
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    // Daftar item untuk bottom navigation
    final List<Map<String, dynamic>> items = [
      {'image': 'assets/images/beranda.svg', 'icon': Icons.home, 'label': 'Beranda'},
      {'image': 'assets/images/riwayat.svg', 'icon': Icons.history, 'label': 'Riwayat'},
      {'image': 'assets/images/setoran.svg', 'icon': Icons.shopping_bag, 'label': 'Setoran'},
      {'image': 'assets/images/pesan.svg', 'icon': Icons.chat_bubble_outline, 'label': 'Pesan'},
      {'image': 'assets/images/profil.svg', 'icon': Icons.person, 'label': 'Profil'},
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      selectedItemColor: AppColors.blue600,
      unselectedItemColor: AppColors.gray900,
      items: List.generate(items.length, (index) {
        final isActive = index == _currentIndex;
        final color = isActive ? AppColors.blue600 : AppColors.gray900;
        
        // Special case for Setoran button (middle button)
        if (index == 2) {
          return BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: isActive ? AppColors.blue600 : AppColors.gray900,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                items[index]['image'],
                width: 24.r,
                height: 24.r,
                color: Colors.white,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading ${items[index]['image']}: $error');
                  return Icon(
                    items[index]['icon'],
                    color: Colors.white,
                    size: 24.r,
                  );
                },
              ),
            ),
            label: items[index]['label'],
          );
        }
        
        // Regular navigation items
        return BottomNavigationBarItem(
          icon: Image.asset(
            items[index]['image'],
            width: 24.r,
            height: 24.r,
            color: color,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading ${items[index]['image']}: $error');
              return Icon(
                items[index]['icon'],
                color: color,
                size: 24.r,
              );
            },
          ),
          label: items[index]['label'],
        );
      }),
    );
  }
}