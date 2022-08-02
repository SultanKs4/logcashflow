import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logcashflow/app/data/helper/currency.dart';
import 'package:logcashflow/app/modules/add/widgets/addform_widget.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  const AddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Tambah ${controller.typeString()}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: (controller.type == 1) ? Colors.green : Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            AddFormWidget(
              controller: controller.dateText,
              labelText: "Tanggal",
              hintText: "Masukkan Tanggal Disini",
              icon: Icons.date_range_rounded,
              color: Get.isDarkMode ? Colors.white70 : Colors.black54,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1945),
                  lastDate: DateTime(2100),
                );
                date ??= DateTime.now();
                controller.date = date;
                controller.dateText.text = DateFormat.yMd().format(date);
              },
            ),
            AddFormWidget(
              controller: controller.valueText,
              labelText: "Nominal",
              hintText: "Masukkan Nominal",
              icon: Icons.money_rounded,
              color: Get.isDarkMode ? Colors.white70 : Colors.black54,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter()
              ],
              onChanged: (value) {
                if (value != "") {
                  controller.value = curr.parse(value).toDouble();
                }
              },
            ),
            AddFormWidget(
              controller: controller.descText,
              labelText: "Keterangan",
              hintText: "Masukkan Keterangan",
              color: Get.isDarkMode ? Colors.white70 : Colors.black54,
              icon: Icons.description_rounded,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          (controller.type == 1) ? Colors.green : Colors.red)),
                  onPressed: () async {
                    var resAdd = await controller.addCashflow();
                    var colorNum = Get.isDarkMode ? 400 : 300;
                    Get.snackbar(
                      margin: const EdgeInsets.all(12),
                      backgroundColor: resAdd != "success"
                          ? Colors.red[colorNum]
                          : Colors.green[colorNum],
                      "Add Data Error",
                      resAdd,
                      snackbarStatus: (status) {
                        if (status == SnackbarStatus.CLOSED &&
                            resAdd == "success") {
                          Get.back();
                        }
                      },
                    );
                    // Get.offAndToNamed(Routes.home);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
