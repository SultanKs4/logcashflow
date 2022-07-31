import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';
import '../widgets/cashflow_item.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cash Flow'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: controller.listCashflow.length,
                    itemBuilder: (context, index) {
                      var cashflow = controller.listCashflow[index];
                      return CasflowItem(cashflow: cashflow);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
