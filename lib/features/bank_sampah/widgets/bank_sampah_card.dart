import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

// Import dari main screen (model menjadi bagian dari file main)
import '../views/bank_sampah_main.dart';

class BankSampahCard extends StatelessWidget {
  final BankSampahModel bankSampah;

  const BankSampahCard({
    Key? key, 
    required this.bankSampah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: GlobalShadow.getShadow(ShadowVariant.small),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian atas kartu - Nama Bank Sampah, Jarak, dan Status
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Bank Sampah
                GlobalText(
                  text: bankSampah.name,
                  variant: TextVariant.mediumSemiBold,
                ),
                
                SizedBox(height: 4.h),
                
                // Jarak dan Status Operasional
                Row(
                  children: [
                    // Jarak
                    GlobalText(
                      text: '${bankSampah.distance} dari lokasimu',
                      variant: TextVariant.smallRegular,
                      color: AppColors.gray600,
                    ),
                    
                    SizedBox(width: 12.w),
                    
                    // Status Operasional
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w, 
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: bankSampah.isActive 
                            ? AppColors.green100 
                            : AppColors.red100,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: GlobalText(
                        text: bankSampah.isActive ? 'Aktif' : 'Tidak Aktif',
                        variant: TextVariant.xSmallSemiBold,
                        color: bankSampah.isActive 
                            ? AppColors.green600 
                            : AppColors.red600,
                      ),
                    ),
                    
                    SizedBox(width: 8.w),
                    
                    // Jam Operasional
                    GlobalText(
                      text: bankSampah.operationalHours,
                      variant: TextVariant.smallRegular,
                      color: AppColors.gray600,
                    ),
                  ],
                ),
                
                SizedBox(height: 4.h),
                
                // Alamat
                GlobalText(
                  text: bankSampah.address,
                  variant: TextVariant.smallRegular,
                  color: AppColors.gray600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(
            height: 1.h,
            thickness: 1.h,
            color: const Color(0xFFF0F0F0),
          ),
          
          // Bagian bawah kartu - Jenis Sampah yang Diterima dan Button Status
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Jenis Sampah
                GlobalText(
                  text: bankSampah.acceptedWaste,
                  variant: TextVariant.smallRegular,
                  color: AppColors.gray600,
                ),
                
                // Button Status Terdaftar
                SizedBox(
                  height: 36.h,
                  child: GlobalButton(
                    text: 'Sudah Terdaftar',
                    variant: ButtonVariant.small,
                    style: ButtonStyle.secondary,
                    disabled: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}