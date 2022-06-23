import 'package:diary/controllers/global_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class Api {
  static Future<Dio> dioAuth() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: "http://192.168.1.117",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Get.find<GlobalController>().token.value}"
        },
        responseType: ResponseType.json);

    return Dio(baseOptions);
  }

  static Future<bool> registerUser(
      {required String email, required String password}) async {
    try {
      Dio dio = await dioAuth();
      Response response = await dio
          .post("/user/register", data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (err) {
      debugPrint("Register User Error $err");
      return false;
    }
  }

  static Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      Dio dio = await dioAuth();
      Response response = await dio
          .post("/user/login", data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return response.data['status'];
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Login User Error $err");
      return null;
    }
  }
}
