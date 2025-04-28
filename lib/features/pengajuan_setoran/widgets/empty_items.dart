import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wanigo_nasabah/core/constants/images.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class EmptyItems extends StatelessWidget {
  const EmptyItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Images.pengajuansetoranEmpty,
            width: 100.w,
            height: 100.h,
          ),
          SizedBox(height: 16.h),
          const GlobalText(
            text: "Katalog Masih Kosong",
            variant: TextVariant.h4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          const GlobalText(
            text:
                "Bank sampah ini belum menerima setoran sampah basah. Coba cari bank sampah lain yang bisa menampung sampah basahmu.",
            variant: TextVariant.xSmallRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
