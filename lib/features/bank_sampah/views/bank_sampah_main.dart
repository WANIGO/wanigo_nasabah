import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart' hide GlobalAppBar;
import '../widgets/global_app_bar.dart';
import '../widgets/bank_sampah_card.dart';

// Model untuk Bank Sampah - didefinisikan di sini untuk menghindari circular dependency
class BankSampahModel {
  final String id;
  final String name;
  final String distance;
  final String address;
  final bool isActive;
  final String operationalHours;
  final String acceptedWaste;
  final bool isRegistered;

  const BankSampahModel({
    required this.id,
    required this.name,
    required this.distance,
    required this.address,
    required this.isActive,
    required this.operationalHours,
    required this.acceptedWaste,
    required this.isRegistered,
  });
}

class BankSampahMainScreen extends StatefulWidget {
  const BankSampahMainScreen({Key? key}) : super(key: key);

  @override
  State<BankSampahMainScreen> createState() => _BankSampahMainScreenState();
}

class _BankSampahMainScreenState extends State<BankSampahMainScreen> {
  // Data dummy
  final List<BankSampahModel> _terdaftarBankSampah = [
    const BankSampahModel(
      id: '1',
      name: 'Bank Sampah Kawan Surabaya',
      distance: '0.5km',
      address: 'Jl. Jojoran Baru III No.30 Mojo, Kec. Gubeng, Surabaya, Jawa Timur',
      isActive: true,
      operationalHours: '10.00 - 22.00',
      acceptedWaste: 'Hanya menerima sampah kering',
      isRegistered: true,
    ),
    const BankSampahModel(
      id: '2',
      name: 'Bank Sampah Kawan Surabaya',
      distance: '0.5km',
      address: 'Jl. Jojoran Baru III No.30 Mojo, Kec. Gubeng, Surabaya, Jawa Timur',
      isActive: true,
      operationalHours: '10.00 - 22.00',
      acceptedWaste: 'Hanya menerima sampah kering',
      isRegistered: true,
    ),
    const BankSampahModel(
      id: '3',
      name: 'Bank Sampah Kawan Surabaya',
      distance: '0.5km',
      address: 'Jl. Jojoran Baru III No.30 Mojo, Kec. Gubeng, Surabaya, Jawa Timur',
      isActive: true,
      operationalHours: '10.00 - 22.00',
      acceptedWaste: 'Hanya menerima sampah kering',
      isRegistered: true,
    ),
  ];

  // Default kondisi ke list view
  bool _isTerdaftarDiBankSampah = true;

  void _navigateToPencarianBankSampah() {
    // TODO: Implementasi navigasi ke halaman pencarian bank sampah
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi ke Pencarian Bank Sampah')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppBar(
        title: '',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Header section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                // Judul
                const GlobalText(
                  text: 'Bank Sampah Saya',
                  variant: TextVariant.h3,
                  color: AppColors.gray600,
                ),
                SizedBox(height: 4.h),
                // Deskripsi
                const GlobalText(
                  text: 'Menampilkan daftar bank sampah yang terdaftar sebagai tempat Anda menabung sampah.',
                  variant: TextVariant.mediumMedium,
                  color: AppColors.gray400,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          
          // Konten utama - berbeda berdasarkan kondisi
          Expanded(
            child: _isTerdaftarDiBankSampah 
              ? _buildKondisiTerdaftar() 
              : _buildKondisiBelumTerdaftar(),
          ),
        ],
      ),
      
      // Bottom section dengan button "Tambah Bank Sampah Baru"
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: Color(0xFFCACACA), width: 1),
          ),
          boxShadow: GlobalShadow.getShadow(ShadowVariant.large),
        ),
        child: GlobalButton(
          text: _isTerdaftarDiBankSampah 
            ? 'Tambah Bank Sampah Baru' 
            : 'Cari Bank Sampah',
          variant: ButtonVariant.medium,
          style: ButtonStyle.primary,
          onPressed: _navigateToPencarianBankSampah,
        ),
      ),
    );
  }

  // =============================================
  // KONDISI 1: Pengguna Belum Terdaftar di Bank Sampah manapun
  // =============================================
  Widget _buildKondisiBelumTerdaftar() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon sebagai pengganti gambar
            Container(
              width: 353.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.recycling,
                size: 100.r,
                color: AppColors.blue300,
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Headline
            const GlobalText(
              text: 'Tidak Terdaftar di Bank Sampah Manapun',
              variant: TextVariant.h4,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 8.h),
            
            // Deskripsi
            const GlobalText(
              text: 'Saat ini, kamu belum terdaftar sebagai nasabah di bank sampah manapun. Yuk, daftarkan dirimu di bank sampah terdekat untuk mulai menabung dan mengelola sampah dengan mudah!',
              variant: TextVariant.smallSemiBold,
              color: AppColors.gray600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // =============================================
  // KONDISI 2: Pengguna Sudah Terdaftar di Bank Sampah
  // =============================================
  Widget _buildKondisiTerdaftar() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _terdaftarBankSampah.length,
      itemBuilder: (context, index) {
        final bankSampah = _terdaftarBankSampah[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: BankSampahCard(bankSampah: bankSampah),
        );
      },
    );
  }
}