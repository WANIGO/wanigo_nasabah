import 'package:get/get.dart';

class SetoranController extends GetxController {
  final RxInt mainTabIndex = 0.obs;
  final RxInt subTabIndex = 0.obs;

  void changeMainTab(int index) {
    mainTabIndex.value = index;
  }

  void changeSubTab(int index) {
    subTabIndex.value = index;
  }
}
