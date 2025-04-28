import 'package:get/get.dart';

class ChooseItemController extends GetxController {
  final selectedCategory = 0.obs;
  final selectedItems = <int>[].obs;

  // Bind totalItems to the length of selectedItems dynamically
  Rx<int> get totalItems => selectedItems.length.obs;

  void toggleCategory(int index) {
    selectedCategory.value = index;
  }

  void toggleItemSelection(int itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
    }
  }
}
