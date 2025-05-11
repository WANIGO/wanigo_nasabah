import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/splash/views/splash_screen.dart'; // Path diperbarui

class NavigationRoutes {
  static String initial = '/';


  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
  ];
}