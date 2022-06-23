import 'package:diary/screens/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  final token = ''.obs;

  @override
  void onInit() {
    ever(token, (_) {
      SharedPreferences.getInstance().then((value) {
        value.setString("token", token.value);
      });
    });
    super.onInit();
  }

  void logOut() {
    token.value = "";
    Get.offAll(const Login());
  }
}
