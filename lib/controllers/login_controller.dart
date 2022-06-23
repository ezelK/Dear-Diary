import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController{
  final emailController= TextEditingController();
  final passwordController= TextEditingController();

@override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}