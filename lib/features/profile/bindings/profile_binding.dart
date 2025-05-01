import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/profile/controllers/profile_step_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy-singleton pattern untuk ProfileStepController
    Get.lazyPut<ProfileStepController>(() => ProfileStepController(), fenix: true);
  }
}