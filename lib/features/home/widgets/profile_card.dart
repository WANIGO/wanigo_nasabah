import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'package:wanigo_nasabah/data/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFCACACA), width: 0.6),
        boxShadow: GlobalShadow.getShadow(ShadowVariant.medium),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 7.h),
          const Divider(
            height: 1,
            thickness: 0.6,
            color: Color(0xFFCACACA),
          ),
          SizedBox(height: 7.h),
          _buildNasabahInfo(),
          SizedBox(height: 7.h),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(context),
        SizedBox(width: 10.w),
        _buildGreeting(),
        _buildPointsBadge(context),
      ],
    );
  }

  Widget _buildNasabahInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nasabah Bank Sampah Kawan',
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Jl Jojoran Baru III, No 30, Kelurahan Mojo',
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 24.r,
          height: 24.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.blue600,
              width: 1,
            ),
          ),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.blue600,
            size: 16.r,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: Image.asset(
        'assets/images/default-img.jpg',
        width: 40.r, // Lebih besar sesuai figma
        height: 40.r, // Lebih besar sesuai figma
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading default-img.jpg: $error');
          return Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(
              Icons.person,
              size: 30.r,
              color: Colors.grey[600],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGreeting() {
    return Expanded(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hai, ',
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 16.sp, // Body Large Medium
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: profile.userName,
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 16.sp, // Heading 6
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF073C9D), width: 0.6),
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFFE0EBFF),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/point_icon.png',
            width: 14.r,
            height: 14.r,
            color: AppColors.blue600,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading point_icon.png: $error');
              return Icon(
                Icons.star,
                size: 14.r,
                color: AppColors.blue600,
              );
            },
          ),
          SizedBox(width: 4.w),
          GlobalText(
            text: '${profile.points} POIN',
            variant: TextVariant.xSmallSemiBold,
            color: AppColors.blue600,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return InkWell(
      onTap: () {
        // Handle click
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Text(
        'Daftar Sebagai Nasabah Bank Sampah',
        style: TextStyle(
          fontFamily: 'Nunito Sans',
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          height: 1.55, // Line height 155%
          color: const Color(0xFF111415), // Grey-900
        ),
      ),
    );
  }
}