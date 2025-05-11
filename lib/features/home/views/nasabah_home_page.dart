import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart';
import 'package:wanigo_nasabah/features/home/views/nasabah_home_screen.dart';

class NasabahHomePage extends StatelessWidget {
  const NasabahHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in
    final AuthController authController = Get.find<AuthController>();
    
    // Make sure user is logged in before proceeding
    if (!authController.isLoggedIn.value) {
      Future.microtask(() => Get.offAllNamed('/login'));
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const NasabahHomeScreen();
  }
}