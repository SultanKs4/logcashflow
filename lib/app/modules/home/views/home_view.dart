import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logcashflow/app/modules/home/widgets/cashflow_chart.dart';
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
                    () => Text(
                      "Pengeluaran: ${controller.expense.value}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    "Pemasukan: ${controller.income.value}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            CashflowChart(controller: controller),
            const SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Income button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.add, arguments: 1)
                              ?.then((value) => controller.refreshData());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 80,
                              child: Icon(
                                Icons.add_rounded,
                                color: Colors.green,
                                size: 80,
                              ),
                            ),
                            Text(
                              "Tambah Pemasukan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Outcome button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.add, arguments: 2)
                              ?.then((value) => controller.refreshData());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 80,
                              child: Icon(
                                Icons.remove_rounded,
                                color: Colors.red,
                                size: 80,
                              ),
                            ),
                            Text(
                              "Tambah Pengeluaran",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Detail button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.detail);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 80,
                              child: Icon(
                                Icons.summarize_rounded,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Text(
                              "Detail Cash Flow",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Setting button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.setting);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 80,
                              child: Icon(
                                Icons.settings_rounded,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Text(
                              "Pengaturan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
