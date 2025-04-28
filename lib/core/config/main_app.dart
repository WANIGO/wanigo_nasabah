import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/core/utils/route_utils.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Wanigo Nasabah',
          debugShowCheckedModeBanner: true,
          initialRoute: NavigationRoutes.setoranSuccess,
          getPages: NavigationRoutes.routes,
          defaultTransition: Transition.noTransition,
          // Widget utama
          home: child,
        );
      },
    );
  }
}
