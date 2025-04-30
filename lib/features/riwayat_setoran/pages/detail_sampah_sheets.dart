import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class DetailSampahSheets extends StatelessWidget {
  const DetailSampahSheets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 250.w,
          height: 250.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: const DecorationImage(
              image: AssetImage(
                  'assets/images/sample.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        const GlobalText(
          text: 'Nama Item Sampah',
          variant: TextVariant.h6,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        const GlobalText(
          text: 'Rp10.000 tiap kilogram',
          variant: TextVariant.smallRegular,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        const Align(
          alignment: Alignment.centerLeft,
          child: GlobalText(
            text: 'Deskripsi Item Sampah',
            variant: TextVariant.mediumBold,
          ),
        ),
        SizedBox(height: 4.h),
        const Align(
          alignment: Alignment.centerLeft,
          child: GlobalText(
            text:
                'Lorem ipsum dulur sit amet  Lorem ipsum dulur sit amet  Lorem ipsum dulur sit amet Lorem ipsum',
            variant: TextVariant.smallRegular,
          ),
        ),
        SizedBox(height: 16.h),
        const Align(
          alignment: Alignment.centerLeft,
          child: GlobalText(
            text: 'Cara Pemilahan',
            variant: TextVariant.mediumBold,
          ),
        ),
        SizedBox(height: 4.h),
        const Align(
          alignment: Alignment.centerLeft,
          child: GlobalText(
            text:
                'Lorem ipsum dulur sit amet  Lorem ipsum dulur sit amet  Lorem ipsum dulur sit amet Lorem ipsum',
            variant: TextVariant.smallRegular,
          ),
        ),
        SizedBox(height: 16.h),
        const Align(
          alignment: Alignment.centerLeft,
          child: GlobalText(
            text: 'Cara Pengemasan',
            variant: TextVariant.mediumBold,
          ),
        ),
        SizedBox(height: 4.h),
        const Align(
          alignment: Alignment.centerLeft,
          child: GlobalText(
            text:
                'Lorem ipsum dulur sit amet  Lorem ipsum dulur sit amet  Lorem ipsum dulur sit amet Lorem ipsum',
            variant: TextVariant.smallRegular,
          ),
        ),
      ],
    );
  }
}
