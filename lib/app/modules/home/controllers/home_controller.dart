import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:logcashflow/app/data/database/cashflow_transaction.dart';
import 'package:logcashflow/app/data/helper/currency.dart';
import 'package:logcashflow/app/data/models/chart.dart';

class HomeController extends GetxController {
  final income = curr.format(0).obs;
  final expense = curr.format(0).obs;
  final dataChart = [
    charts.Series<Chart, DateTime>(
      id: 'income',
      data: [Chart()],
      domainFn: (Chart chart, _) => chart.date,
      measureFn: (Chart chart, index) => chart.value,
    ),
  ].obs;
  final dataChartFl = [LineChartBarData(spots: const [])].obs;
  final bottomAxis = DateTime.now().obs;
  final maxY = 10000.0.obs;
  final colorBorder = Colors.white70.obs;

  Future<Map<String, dynamic>> getDataChartFl() async {
    var dataCashflow = await CashflowTransaction.getLastMonthMapList();
    List<Chart> dataChartIncome = [Chart()];
    List<Chart> dataChartExpense = [Chart()];

    if (dataCashflow[0].isNotEmpty) {
      dataChartIncome = dataCashflow[0];
    }

    if (dataCashflow[1].isNotEmpty) {
      dataChartExpense = dataCashflow[1];
    }

    var listIncome = dataChartIncome.map((e) => e.value).reduce(max);
    var listExpense = dataChartExpense.map((e) => e.value).reduce(max);
    return {
      "dataList": [
        LineChartBarData(
          color: Colors.green[400],
          isCurved: true,
          barWidth: 4,
          spots: dataChartIncome
              .map((e) => FlSpot(e.date.day.toDouble(), e.value.toDouble()))
              .toList(),
        ),
        LineChartBarData(
            color: Colors.red[400],
            isCurved: true,
            barWidth: 4,
            spots: dataChartExpense
                .map((e) => FlSpot(e.date.day.toDouble(), e.value.toDouble()))
                .toList())
      ],
      "axis": dataChartIncome[0].date,
      "max": (max(listIncome, listExpense) + 10000).toDouble()
    };
  }

  Future<void> refreshData() async {
    var dataFl = await getDataChartFl();
    var data = await CashflowTransaction.getSummaryMonth();
    income.value = curr.format(data['income']);
    expense.value = curr.format(data['expense']);
    dataChartFl.value = dataFl['dataList'];
    bottomAxis.value = dataFl['axis'];
    maxY.value = dataFl['max'];
    refreshUiTheme();
  }

  void refreshUiTheme() {
    colorBorder.value = Get.isDarkMode ? Colors.white70 : Colors.black54;
  }

  @override
  void onReady() async {
    super.onReady();
    await refreshData();
    // var dataIncome = await CashflowTransaction.getLastMonthList(1);
    // var dataOutcome = await CashflowTransaction.getLastMonthList(2);
  }
}
