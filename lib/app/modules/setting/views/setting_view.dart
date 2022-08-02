import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logcashflow/app/modules/views/passwordform_widget.dart';
import 'package:logcashflow/app/routes/app_pages.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () => controller.changeThemeMode(Get.isDarkMode),
              icon: controller.darkMode.value
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ubah Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => PasswordFormWidget(
                    controller: controller.passwordOld,
                    obscureText: true,
                    labelText: "Password saat ini",
                    hintText: "Masukkan password saat ini",
                    icon: Icons.lock,
                    color: controller.darkMode.value
                        ? Colors.white70
                        : Colors.black54,
                  ),
                ),
                Obx(
                  () => PasswordFormWidget(
                    controller: controller.passwordNew,
                    obscureText: true,
                    labelText: "Password baru",
                    hintText: "Masukkan password baru",
                    icon: Icons.lock,
                    color: controller.darkMode.value
                        ? Colors.white70
                        : Colors.black54,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        String result = await controller.updatePassword();
                        var colorNum = Get.isDarkMode ? 400 : 300;

                        var bg = Colors.red[colorNum];
                        var title = "Ubah Password Error";
                        var message = result;

                        if (result == "sukses") {
                          bg = Colors.green[colorNum];
                          title = "Ubah Password Sukses";
                          message = "Berhasil mengubah password";
                        }

                        Get.snackbar(
                          margin: const EdgeInsets.all(12),
                          backgroundColor: bg,
                          title,
                          message,
                          snackbarStatus: (status) {
                            if (status == SnackbarStatus.CLOSED &&
                                result == "sukses") {
                              Get.offAllNamed(Routes.login);
                            }
                          },
                        );
                      },
                      child: const Text("Submit")),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/img/profile.jpg",
                  height: 150,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mengenai Aplikasi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Aplikasi ini dibuat oleh:"),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Nama: Sultan Achmad Qum Masykuro NS"),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("NIM: 1841720019"),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        "Tanggal: ${DateFormat.yMMMMEEEEd().format(DateTime(2022, 7, 27))}"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
