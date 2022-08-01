import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logcashflow/app/modules/home/widgets/homebutton_widget.dart';
import 'package:logcashflow/app/modules/home/widgets/linechart_widget.dart';
import 'package:logcashflow/app/modules/home/widgets/textsummary_widget.dart';
import 'package:logcashflow/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: const Text(
                    "Rangkuman Bulan Ini",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Obx(
                    () => TextSummaryWidget(
                      text: "Pengeluaran: ${controller.expense.value}",
                      color: Colors.red,
                    ),
                  ),
                ),
                Obx(
                  () => TextSummaryWidget(
                    text: "Pemasukan: ${controller.income.value}",
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // CashflowChart(controller: controller),
            LineChartWidget(controller: controller),
            const SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Income button
                    ButtonHomeWidget(
                      controller: controller,
                      text: "Tambah Pemasukan",
                      icon: Icons.add_rounded,
                      color: Colors.green,
                      func: () {
                        Get.toNamed(Routes.add, arguments: 1)
                            ?.then((value) => controller.refreshData());
                      },
                    ),
                    // Outcome button
                    ButtonHomeWidget(
                      controller: controller,
                      text: "Tambah Pengeluaran",
                      icon: Icons.remove,
                      color: Colors.red,
                      func: () {
                        Get.toNamed(Routes.add, arguments: 2)
                            ?.then((value) => controller.refreshData());
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Detail button
                    ButtonHomeWidget(
                      controller: controller,
                      text: "Detail Cash Flow",
                      icon: Icons.summarize,
                      color: Colors.blue,
                      func: () {
                        Get.toNamed(Routes.detail);
                      },
                    ),
                    // Setting button
                    ButtonHomeWidget(
                      controller: controller,
                      icon: Icons.settings,
                      text: "Pengaturan",
                      color: Colors.blue,
                      func: () {
                        Get.toNamed(Routes.setting);
                      },
                    ),
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
