import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logcashflow/app/modules/views/passwordform_widget.dart';
import 'package:logcashflow/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/img/logo_cashflow.png",
                  width: 300,
                  height: 300,
                ),
                const Text(
                  "Log Cashflow",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Column(
              children: [
                PasswordFormWidget(
                    controller: controller.usernameText,
                    obscureText: false,
                    labelText: "Username",
                    hintText: "Masukkan username",
                    icon: Icons.person),
                PasswordFormWidget(
                    controller: controller.passwordText,
                    obscureText: true,
                    labelText: "Password",
                    hintText: "Masukkan password",
                    icon: Icons.lock),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      // style: ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        String resLogin = await controller.checkLogin();
                        if (resLogin == "success") {
                          Get.offAndToNamed(Routes.home);
                        } else {
                          Get.snackbar(
                              margin: const EdgeInsets.all(12),
                              backgroundColor: Colors.red[300],
                              "Login Error",
                              resLogin);
                        }
                      },
                      child: const Text("Login")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
