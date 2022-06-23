import 'package:diary/controllers/binding.dart';
import 'package:diary/controllers/global_controller.dart';
import 'package:diary/screens/login.dart';
import 'package:diary/screens/notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            final token = snapshot.data!.getString("token");
            if (token != null && token.isNotEmpty) {
              Get.find<GlobalController>().token.value = token;
              return const NotesPage();
            }
            return const Login();
          }
          return const CircularProgressIndicator();
        },
      )),
    ),
  );
}
