import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final double height;

  const GlobalAppBar({
    Key? key,
    this.title = '',
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
    this.centerTitle = true,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: centerTitle,
      title: title.isNotEmpty
          ? GlobalText(
              text: title,
              variant: TextVariant.mediumSemiBold,
              color: AppColors.gray600,
            )
          : Padding(
              padding: EdgeInsets.only(left: showBackButton ? 0 : 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: AppColors.blue500,
                    size: 24.r,
                  ),
                  SizedBox(width: 4.w),
                  const GlobalText(
                    text: 'WANIGO!',
                    variant: TextVariant.mediumBold,
                    color: AppColors.blue500,
                  ),
                ],
              ),
            ),
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.gray600,
                size: 20.r,
              ),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: const Color(0xFFE6E6E6),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}