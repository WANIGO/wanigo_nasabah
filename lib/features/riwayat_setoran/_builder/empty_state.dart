import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wanigo_nasabah/core/constants/images.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class EmptyStateWidgets extends StatelessWidget {
  const EmptyStateWidgets({super.key});

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
            Images.emptySetoran,
            width: 100.w,
            height: 100.h,
          ),
          SizedBox(height: 16.h),
          const GlobalText(
            text: "Data Setoran Tidak Ditemukan",
            variant: TextVariant.h4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          const GlobalText(
            text:
                "Belum ada data setoran sampah yang tercatat. Pastikan kamu telah mengajukan setoran sampah atau coba periksa kembali jadwal setoran yang telah dibuat.",
            variant: TextVariant.xSmallRegular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
              width: double.infinity,
              child: GlobalButton(
                text: "Buat Setoran Baru",
                onPressed: () {},
                variant: ButtonVariant.medium,
              ))
        ],
      ),
    );
  }
}
