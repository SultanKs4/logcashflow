import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logcashflow/app/data/database/users_transaction.dart';
import 'package:logcashflow/app/data/models/users.dart';

class SettingController extends GetxController {
  late TextEditingController passwordOld;
  late TextEditingController passwordNew;
  final box = GetStorage();
  final darkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordOld = TextEditingController();
    passwordNew = TextEditingController();
    darkMode.value = box.read('darkmode') ?? false;
  }

  void changeThemeMode(bool isDarkMode) {
    darkMode.value = !isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    box.write('darkmode', darkMode.value);
  }

  Future<String> updatePassword() async {
    if (passwordOld.text.isEmpty && passwordNew.text.isEmpty) {
      return "password saat ini dan baru kosong";
    }

    if (passwordOld.text.isEmpty) {
      return "password saat ini kosong";
    }

    if (passwordNew.text.isEmpty) {
      return "password baru kosong";
    }

    Users user = box.read("user");

    var checkPassword = await UsersTransaction.checkPassword(
        user.id, sha512.convert(utf8.encode(passwordOld.text)).toString());

    if (checkPassword.isEmpty) {
      return "password saat ini berbeda";
    }

    user.password = sha512.convert(utf8.encode(passwordNew.text)).toString();

    var updatePassword = await UsersTransaction.update(user, user.id);

    if (updatePassword != user.id) {
      return "gagal mengubah password";
    }

    box.remove("user");

    return 'sukses';
  }
}
