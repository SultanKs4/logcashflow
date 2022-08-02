import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logcashflow/app/data/database/cashflow_transaction.dart';
import 'package:logcashflow/app/data/models/cashflow.dart';
import 'package:logcashflow/app/data/models/users.dart';

class AddController extends GetxController {
  int type = Get.arguments;
  late TextEditingController dateText;
  DateTime date = DateTime.now();
  late TextEditingController valueText;
  double value = 0;
  late TextEditingController descText;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    dateText = TextEditingController();
    valueText = TextEditingController();
    descText = TextEditingController();
  }

  @override
  void onClose() {
    dateText.dispose();
    valueText.dispose();
    descText.dispose();
    super.onClose();
  }

  Future<String> addCashflow() async {
    if (value.isEqual(0.0)) {
      return "nominal tidak boleh kosong";
    }

    if (descText.text.isEmpty) {
      return "deskripsi tidak boleh kosong";
    }

    Users user = box.read("user");
    Cashflow data = Cashflow(
      usersId: user.id,
      type: type,
      date: date,
      value: value,
      description: descText.text,
    );
    await CashflowTransaction.addCashflow(data);
    return "success";
  }

  String typeString() {
    if (type == 1) {
      return "Pemasukan";
    }
    return "Pengeluaran";
  }
}
