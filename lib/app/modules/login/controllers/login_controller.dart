import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logcashflow/app/data/database/users_transaction.dart';
import 'package:logcashflow/app/data/models/users.dart';

class LoginController extends GetxController {
  late TextEditingController usernameText;
  late TextEditingController passwordText;
  String? loginErrorText;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    usernameText = TextEditingController();
    passwordText = TextEditingController();
    initializeDateFormatting();
  }

  @override
  void onClose() {
    usernameText.dispose();
    passwordText.dispose();
    super.onClose();
  }

  Future<String> checkLogin() async {
    if (usernameText.text.isEmpty && passwordText.text.isEmpty) {
      return "Username and Password empty";
    }

    if (usernameText.text.isEmpty) {
      return "Username empty";
    }

    if (passwordText.text.isEmpty) {
      return "Password empty";
    }

    var result = await UsersTransaction.findUsers(
      usernameText.text,
      sha512.convert(utf8.encode(passwordText.text)).toString(),
    );

    if (result.isEmpty) {
      return "Username dan Password not found";
    }

    var user = Users.fromMap(result);
    box.write("user", user);

    return "success";
  }
}
