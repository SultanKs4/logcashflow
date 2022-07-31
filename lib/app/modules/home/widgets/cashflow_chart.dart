import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logcashflow/app/modules/home/controllers/home_controller.dart';

class CashflowChart extends StatelessWidget {
  final HomeController controller;

  const CashflowChart({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: charts.TimeSeriesChart(
          controller.dataChart.value,
          animate: true,
        ),
      ),
    );
  }
}
