import 'package:diary/controllers/global_controller.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}
