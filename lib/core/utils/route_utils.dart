import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/pages/choose_item_catalog_screen.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/pages/setoran_success_screen.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/pengajuan_setoran_screen.dart';
import 'package:wanigo_nasabah/features/splash/splash_screen.dart';

class NavigationRoutes {
  static String initial = '/';
  static String pengajuanSetoran = '/pengajuan-setoran';
  static String chooseItems = '/choose-items';
  static String setoranSuccess = '/setoran-success';


  static List<GetPage> routes = [
    GetPage(name: initial, page: () => SplashScreen()),
    GetPage(name: pengajuanSetoran, page: () => const PengajuanSetoranScreen()),
    GetPage(name: chooseItems, page: () => ChooseItemCatalogScreen()),
    GetPage(name: setoranSuccess, page: () => const SetoranSuccessScreen()),

  ];
}
