import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankSampahCard extends StatelessWidget {
  final String title;
  final String distance;
  final String status;
  final String time;
  final String address;
  final bool isRegistered;

  const BankSampahCard({
    super.key,
    required this.title,
    required this.distance,
    required this.status,
    required this.time,
    required this.address,
    required this.isRegistered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.3.w,
            color: const Color(0xFFCACACA),
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x050D0D12),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: const Color(0x0A0D0D12),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w700,
              height: 1.4,
              letterSpacing: -0.54,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              SizedBox(
                width: 134.w,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: distance,
                        style: TextStyle(
                          color: const Color(0xFF212729),
                          fontSize: 12.sp,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.55,
                        ),
                      ),
                      // TextSpan(
                      //   text: ' dari lokasimu',
                      //   style: TextStyle(
                      //     color: const Color(0xFF212729),
                      //     fontSize: 12.sp,
                      //     fontFamily: 'Nunito Sans',
                      //     fontWeight: FontWeight.w600,
                      //     height: 1.55,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Row(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: const Color(0xFF16A34A),
                      fontSize: 12.sp,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.55,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    time,
                    style: TextStyle(
                      color: const Color(0xFF212729),
                      fontSize: 12.sp,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 322.w,
            child: Text(
              address,
              style: TextStyle(
                color: const Color(0xFF212729),
                fontSize: 12.sp,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w500,
                height: 1.55,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // width: 182.w,
                child: Text(
                  'Hanya menerima sampah kering',
                  style: TextStyle(
                    color: const Color(0xFF212729),
                    fontSize: 12.sp,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.55,
                  ),
                ),
              ),
              Container(
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: ShapeDecoration(
                  color: isRegistered ? const Color(0xFFADC8F8) : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: const Color(0xFF084BC3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x0F0D0D12),
                      blurRadius: 2.r,
                      offset: Offset(0, 1.h),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isRegistered ? 'Sudah Terdaftar' : 'Daftar',
                    style: TextStyle(
                      color: const Color(0xFF084BC3),
                      fontSize: 12.sp,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
