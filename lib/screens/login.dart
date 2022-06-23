import 'package:diary/controllers/global_controller.dart';
import 'package:diary/controllers/login_controller.dart';
import 'package:diary/screens/notes.dart';
import 'package:diary/services/api.dart';
import 'package:diary/styles/login_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/buttons.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextFormField(
                style: loginStyle,
                controller: controller.emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (txt) {
                  if (!GetUtils.isEmail(txt!)) {
                    return "Invalid email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(62, 39, 35, 1)),
                    ),
                    hintText: 'Mail',
                    hintStyle: loginStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextFormField(
                style: loginStyle,
                controller: controller.passwordController,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (txt) {
                  if (txt!.length < 6) {
                    return "Invalid password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(62, 39, 35, 1)),
                    ),
                    hintText: 'Password',
                    hintStyle: loginStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        style: loginPageButton,
                        onPressed: () async {
                          final token = await Api.loginUser(
                            email: controller.emailController.text,
                            password: controller.passwordController.text,
                          );
                          if (token != null) {
                            Get.find<GlobalController>().token.value = token;
                            Get.off(const NotesPage());
                          } else {
                            Get.snackbar('error', 'Login failed');
                          }
                        },
                        child: const Text('LOGIN')),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                        style: loginPageButton,
                        onPressed: () async {
                          final isRegistered = await Api.registerUser(
                            email: controller.emailController.text,
                            password: controller.passwordController.text,
                          );
                          if (isRegistered) {
                            controller.emailController.clear();
                            controller.passwordController.clear();
                          } else {
                            Get.snackbar('error', 'Register failed');
                          }
                        },
                        child: const Text('REGISTER')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
