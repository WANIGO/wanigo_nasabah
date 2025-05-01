import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart' as wanigo_ui;
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart';

class NasabahHomeScreen extends StatelessWidget {
  const NasabahHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get user from AuthController
    final AuthController authController = Get.find<AuthController>();
    final String userName = authController.user.value?.name ?? 'Nasabah';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background color for upper part
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 320.h,
            child: Container(
              color: const Color(0xFFDCE8FF),
            ),
          ),
          
          // Plant decoration
          Positioned(
            top: 240.h,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/tanaman.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100.h,
                  color: Colors.transparent,
                );
              },
            ),
          ),
          
          // White background for bottom part with rounded corners
          Positioned(
            top: 320.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                    spreadRadius: -2,
                  ),
                ],
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile card
                          _buildProfileCard(userName),
                          
                          SizedBox(height: 16.h),
                          
                          // Tabungan card
                          _buildTabunganCard(),
                          
                          SizedBox(height: 16.h),
                          
                          // Calendar card 
                          _buildCalendarCard(),
                          
                          SizedBox(height: 32.h),
                          
                          // Features title
                          wanigo_ui.GlobalText(
                            text: 'Fitur Aplikasi WANIGO!',
                            variant: wanigo_ui.TextVariant.h5,
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // Feature icons
                          _buildFeatureIcons(),
                          
                          SizedBox(height: 24.h),
                          
                          // Setoran sampah title
                          wanigo_ui.GlobalText(
                            text: 'Setoran Sampah Terkini',
                            variant: wanigo_ui.TextVariant.h5,
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // Setoran sampah card
                          _buildSetoranSampahCard(),
                          
                          SizedBox(height: 80.h), // Space for bottom navigation
                        ],
                      ),
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

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: wanigo_ui.GlobalShadow.getShadow(wanigo_ui.ShadowVariant.small),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App logo
          Row(
            children: [
              Image.asset(
                'assets/images/WANIGO_logo.png',
                width: 24.r,
                height: 24.r,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.recycling,
                    size: 24.r,
                    color: wanigo_ui.AppColors.blue500,
                  );
                },
              ),
              SizedBox(width: 8.w),
              wanigo_ui.GlobalText(
                text: 'WANIGO!',
                variant: wanigo_ui.TextVariant.h4,
                color: wanigo_ui.AppColors.blue500,
              ),
            ],
          ),
          
          // Notification icon
          IconButton(
            icon: Icon(Icons.notifications_none, color: wanigo_ui.AppColors.gray600),
            onPressed: () {
              // Handle notification tap
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(String userName) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: wanigo_ui.GlobalShadow.getShadow(wanigo_ui.ShadowVariant.medium),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar, greeting and points
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 30.r,
                    color: wanigo_ui.AppColors.orange500,
                  ),
                ),
              ),
              
              SizedBox(width: 12.w),
              
              // Greeting text
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: wanigo_ui.AppColors.gray600,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      const TextSpan(text: 'Hai, '),
                      TextSpan(
                        text: userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Points badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0EBFF), // AppColors.bgPoin
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(color: wanigo_ui.AppColors.blue700, width: 0.6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/poin.svg',
                      width: 16.r,
                      height: 16.r,
                      color: wanigo_ui.AppColors.blue700,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.stars,
                          size: 16.r,
                          color: wanigo_ui.AppColors.blue700,
                        );
                      },
                    ),
                    SizedBox(width: 4.w),
                    wanigo_ui.GlobalText(
                      text: '0 POIN',
                      variant: wanigo_ui.TextVariant.xSmallBold,
                      color: wanigo_ui.AppColors.blue700,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Divider(height: 24.h, color: wanigo_ui.AppColors.gray200),
          
          // Daftar sebagai nasabah button
          InkWell(
            onTap: () {
              // Handle daftar sebagai nasabah
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wanigo_ui.GlobalText(
                    text: 'Daftar Sebagai Nasabah Bank Sampah',
                    variant: wanigo_ui.TextVariant.smallSemiBold,
                    color: wanigo_ui.AppColors.gray600,
                  ),
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: wanigo_ui.AppColors.blue700,
                        width: 1.5,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: wanigo_ui.AppColors.blue700,
                      size: 20.r,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabunganCard() {
    return Container(
      width: 353.w,
      height: 159.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white, width: 3),
        gradient: const LinearGradient(
          colors: [Color(0xFF003CFF), Color(0xFF0097FF)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        boxShadow: wanigo_ui.GlobalShadow.getShadow(wanigo_ui.ShadowVariant.medium),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const wanigo_ui.GlobalText(
                  text: 'Total Saldo Tabungan',
                  variant: wanigo_ui.TextVariant.smallRegular,
                  color: Colors.white,
                ),
                SizedBox(height: 4.h),
                const wanigo_ui.GlobalText(
                  text: 'Rp24.000,00',
                  variant: wanigo_ui.TextVariant.h4,
                  color: Colors.white,
                ),
                SizedBox(height: 16.h),
                const wanigo_ui.GlobalText(
                  text: 'Total Sampah Terpilahkan',
                  variant: wanigo_ui.TextVariant.smallRegular,
                  color: Colors.white,
                ),
                SizedBox(height: 4.h),
                const wanigo_ui.GlobalText(
                  text: '12 kilogram',
                  variant: wanigo_ui.TextVariant.h4,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              wanigo_ui.GlobalButton(
                text: 'Cek Tabungan',
                variant: wanigo_ui.ButtonVariant.small, 
                style: wanigo_ui.ButtonStyle.secondary,
                onPressed: () {
                  // Navigate to tabungan details
                },
              ),
              SizedBox(height: 8.h),
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/wanigo_logo.png',
                    width: 80.r,
                    height: 80.r,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.recycling,
                        size: 60.r,
                        color: wanigo_ui.AppColors.blue500,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: wanigo_ui.AppColors.gray200),
        boxShadow: wanigo_ui.GlobalShadow.getShadow(wanigo_ui.ShadowVariant.small),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarDateBox(),
          SizedBox(width: 12.w),
          _buildCalendarContent(),
        ],
      ),
    );
  }

  Widget _buildCalendarDateBox() {
    return Container(
      width: 100.r,
      height: 100.r,
      decoration: BoxDecoration(
        color: wanigo_ui.AppColors.blue500,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const wanigo_ui.GlobalText(
                  text: '18',
                  variant: wanigo_ui.TextVariant.h3,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const wanigo_ui.GlobalText(
                    text: 'Sep',
                    variant: wanigo_ui.TextVariant.smallBold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 18.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: wanigo_ui.GlobalText(
                text: 'Selasa',
                variant: wanigo_ui.TextVariant.smallBold,
                color: wanigo_ui.AppColors.blue700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4.w,
                height: 40.h,
                margin: EdgeInsets.only(top: 2.h, right: 8.w),
                decoration: BoxDecoration(
                  color: wanigo_ui.AppColors.blue500,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Expanded(
                child: wanigo_ui.GlobalText(
                  text: 'Jadwal Pemilahan/Penyetoran Sampah Anda Belum Dibuat.',
                  variant: wanigo_ui.TextVariant.smallSemiBold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: wanigo_ui.GlobalButton(
              text: 'Atur Jadwal Sekarang',
              variant: wanigo_ui.ButtonVariant.medium,
              onPressed: () {
                // Navigate to schedule page
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFeatureIcon(
          label: 'Edukasi',
          iconPath: Icons.school,
        ),
        _buildFeatureIcon(
          label: 'Laporan',
          iconPath: Icons.assessment,
        ),
        _buildFeatureIcon(
          label: 'Juara',
          iconPath: Icons.emoji_events,
        ),
        _buildFeatureIcon(
          label: 'Misi',
          iconPath: Icons.flag,
        ),
        _buildFeatureIcon(
          label: 'Lainnya',
          iconPath: Icons.apps,
        ),
      ],
    );
  }

  Widget _buildFeatureIcon({required String label, required IconData iconPath}) {
    return Column(
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            color: wanigo_ui.AppColors.blue100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              iconPath,
              size: 24.r,
              color: wanigo_ui.AppColors.blue500,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        wanigo_ui.GlobalText(
          text: label,
          variant: wanigo_ui.TextVariant.xSmallRegular,
        ),
      ],
    );
  }

  Widget _buildSetoranSampahCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: InkWell(
          onTap: () {
            // Handle card tap
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Row(
            children: [
              _buildSetoranSampahIcon(),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wanigo_ui.GlobalText(
                      text: 'Buat Rencana Setoran',
                      variant: wanigo_ui.TextVariant.mediumSemiBold,
                    ),
                    SizedBox(height: 4.h),
                    wanigo_ui.GlobalText(
                      text: 'Mulai ajukan setoran sampah Anda & berkontribusi menjaga lingkungan',
                      variant: wanigo_ui.TextVariant.smallRegular,
                      color: wanigo_ui.AppColors.gray500,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: wanigo_ui.AppColors.gray500, size: 24.r),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSetoranSampahIcon() {
    return Stack(
      children: [
        Container(
          width: 60.r,
          height: 60.r,
          decoration: BoxDecoration(
            color: const Color(0xFFD0B69B), // Light brown color
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Icon(
              Icons.inventory_2,
              size: 40.r,
              color: Colors.brown[700],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.recycling,
              size: 20.r,
              color: wanigo_ui.AppColors.blue500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: wanigo_ui.GlobalShadow.getShadow(wanigo_ui.ShadowVariant.medium),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: wanigo_ui.AppColors.blue800,
        unselectedItemColor: wanigo_ui.AppColors.gray500,
        currentIndex: 0,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 24.r,
              color: wanigo_ui.AppColors.blue800,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              size: 24.r,
              color: wanigo_ui.AppColors.gray500,
            ),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 46.r,
              height: 46.r,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 24.r,
                  color: Colors.white,
                ),
              ),
            ),
            label: 'Setoran',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 24.r,
              color: wanigo_ui.AppColors.gray500,
            ),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24.r,
              color: wanigo_ui.AppColors.gray500,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}