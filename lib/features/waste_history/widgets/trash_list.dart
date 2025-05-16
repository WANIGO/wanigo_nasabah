import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class TrashPriceCard extends StatelessWidget {
  final String name;
  final double weightKg;
  final int totalPrice;
  final int pricePerKg;
  final VoidCallback? onTap;

  const TrashPriceCard({
    super.key,
    required this.name,
    required this.weightKg,
    required this.totalPrice,
    required this.pricePerKg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Kiri: Nama dan Berat
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: name,
                  variant: TextVariant.mediumSemiBold,
                ),
                SizedBox(height: 4.h),
                GlobalText(
                  text: 'Berat item ${weightKg.toStringAsFixed(1)} kg',
                  variant: TextVariant.xSmallRegular,
                ),
              ],
            ),
            // Kanan: Harga
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GlobalText(
                  text: 'Rp.${totalPrice.toStringAsFixed(0)}',
                  variant: TextVariant.mediumSemiBold,
                ),
                SizedBox(height: 4.h),
                GlobalText(
                  text: '(Rp.${pricePerKg.toStringAsFixed(0)}/kg)',
                  variant: TextVariant.xSmallRegular,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
