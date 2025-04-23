import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/splash/splash_screen.dart';

class NavigationRoutes {
  static String initial = '/';


  static List<GetPage> routes = [
    GetPage(name: initial, page: () => SplashScreen()),

  ];
}
