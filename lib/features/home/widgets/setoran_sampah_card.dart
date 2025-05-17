import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'package:wanigo_nasabah/data/models/setoran_sampah_model.dart';

class SetoranSampahCard extends StatelessWidget {
  final SetoranSampahModel setoran;

  const SetoranSampahCard({
    super.key,
    required this.setoran,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.22.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFCACACA)),
        color: Colors.white,
        boxShadow: GlobalShadow.getShadow(ShadowVariant.medium),
      ),
      child: Row(
        children: [
          _buildIconWithBg(context),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: setoran.title,
                  variant: TextVariant.mediumSemiBold,
                ),
                SizedBox(height: 4.h),
                GlobalText(
                  text: setoran.description,
                  variant: TextVariant.smallRegular,
                  color: AppColors.gray500,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppColors.gray600,
            size: 24.r,
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithBg(BuildContext context) {
    return Container(
      width: 60.r,
      height: 60.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              'assets/images/setoran_card.png',
              width: 60.r,
              height: 60.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Error loading setoran_card.png: $error');
                return Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Image.asset(
                    'assets/images/box_icon.png',
                    width: 36.r,
                    height: 36.r,
                    color: Colors.brown,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading box_icon.png: $error');
                      return Icon(
                        Icons.inventory_2,
                        color: Colors.brown,
                        size: 36.r,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/recycle_icon.png',
              width: 18.r,
              height: 18.r,
              color: AppColors.blue600,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Error loading recycle_icon.png: $error');
                return Icon(
                  Icons.recycling,
                  color: AppColors.blue600,
                  size: 18.r,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}