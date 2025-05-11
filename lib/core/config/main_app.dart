import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:wanigo_nasabah/routes/app_pages.dart';
import 'package:wanigo_ui/wanigo_ui.dart'; // UI package

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Sesuai desain
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Wanigo Nasabah',
          theme: AppTheme.lightTheme, // Gunakan theme dari Wanigo UI package
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash, // Mulai dari splash screen
          getPages: AppPages.routes,
          defaultTransition: Transition.fadeIn,
        );
      },
    );
  }
}