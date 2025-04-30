import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class ItemSampahCard extends StatelessWidget {
  final String title;
  final String pricePerKg;
  final VoidCallback onDelete;

  const ItemSampahCard({
    super.key,
    required this.title,
    required this.pricePerKg,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      child: Column(
        children: [
          Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.grey.shade200,
              ),
              child: const Icon(Icons.image_outlined, color: Colors.grey),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    text: title,
                    variant: TextVariant.mediumMedium,
                  ),
                  GlobalText(
                    text: pricePerKg,
                    variant: TextVariant.smallMedium,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onDelete,
            ),
          ],
        ),
          SizedBox(height: 8.h),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ]
      ),
    );
  }
}
