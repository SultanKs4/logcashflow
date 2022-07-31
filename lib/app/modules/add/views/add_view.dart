import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logcashflow/app/data/helper/currency.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  const AddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            TextFormField(
              controller: controller.dateText,
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
              decoration: const InputDecoration(
                labelText: "Tanggal",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: "Masukkan Tanggal Disini",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.valueText,
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
              decoration: const InputDecoration(
                labelText: "Nominal",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: "Masukkan Nominal",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.descText,
              decoration: const InputDecoration(
                labelText: "Keterangan",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: "Masukkan Keterangan",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          (controller.type == 1) ? Colors.green : Colors.red)),
                  onPressed: () async {
                    controller.addCashflow();
                    // Get.offAndToNamed(Routes.home);
                    Get.back();
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
