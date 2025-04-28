import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasteItemCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap; // Add the onTap handler

  const WasteItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap, // Accept onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap
      child: Container(
        width: 164.w,
        height: 240.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFCEDEFB) : Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color(0xFF084BC3) : const Color(0xFFCACACA),
            width: isSelected ? 1.5 : 0.3,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x050D0D12),
              blurRadius: 8,
              offset: const Offset(0, 4),
              spreadRadius: -1,
            ),
            BoxShadow(
              color: const Color(0x0A0D0D12),
              blurRadius: 10,
              offset: const Offset(0, 5),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.8.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            title,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFF052D75)
                                  : const Color(0xFF212729),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            price,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFF0A5AEB)
                                  : const Color(0xFF464B4D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12.w,
              top: 12.h,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFCEDEFB) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFCACACA),
                    width: 0.5,
                  ),
                ),
                child: Icon(
                  isSelected ? Icons.check_circle : Icons.add,
                  color: isSelected ? Colors.blue : Colors.grey,
                  size: 20.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
