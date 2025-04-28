import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wanigo_nasabah/core/constants/images.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class NonNasabahWidgets extends StatelessWidget {
  const NonNasabahWidgets({super.key});

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
            Images.pengajuansetoranStore,
            width: 100.w,
            height: 100.h,
          ),
          SizedBox(height: 16.h),
          const GlobalText(
            text: "Tidak Terdaftar di Bank Sampah Manapun",
            variant: TextVariant.h4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          const GlobalText(
            text:
                "Saat ini, kamu belum terdaftar sebagai nasabah di bank sampah manapun. Yuk, daftarkan dirimu di bank sampah terdekat untuk mulai menabung dan mengelola sampah dengan mudah!",
            variant: TextVariant.xSmallRegular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: GlobalButton(
              text: "Temukan Bank Sampah Terdekat",
              onPressed: () {

              },
              variant: ButtonVariant.medium,
          )
          )
        ],
      ),
    );
  }
}
