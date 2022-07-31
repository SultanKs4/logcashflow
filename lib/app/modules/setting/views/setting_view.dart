import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logcashflow/app/routes/app_pages.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.passwordOld,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password saat ini",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Masukkan password saat ini",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.passwordNew,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password baru",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Masukkan password baru",
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        String result = await controller.updatePassword();

                        var bg = Colors.red[300];
                        var title = "Ubah Password Error";
                        var message = result;

                        if (result == "sukses") {
                          bg = Colors.green[300];
                          title = "Ubah Password Sukses";
                          message = "Berhasil mengubah password";
                        }

                        Get.snackbar(
                          margin: const EdgeInsets.all(12),
                          backgroundColor: bg,
                          title,
                          message,
                          duration: const Duration(seconds: 3),
                          snackbarStatus: (status) {
                            if (status == SnackbarStatus.CLOSED) {
                              Get.offAllNamed(Routes.login);
                            }
                          },
                        );

                        // if (result == "sukses") {
                        //   Future.delayed(
                        //     const Duration(seconds: 3),
                        //     () {
                        //       Get.offAllNamed(Routes.login);
                        //     },
                        //   );
                        // }
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
