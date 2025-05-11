import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/features/bank_sampah/views/bank_sampah_main.dart';

void main() {
  // Tambahkan ini untuk membantu debugging error LateInitializationError
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('Error details: ${details.exception}');
    print('Stack trace: ${details.stack}');
  };
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // Ukuran iPhone 16
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wanigo Bank Sampah',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: child,
        );
      },
      child: const BankSampahMainScreen(),
    );
  }
}