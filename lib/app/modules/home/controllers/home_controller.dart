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

  Future<List<charts.Series<Chart, DateTime>>> getDataChart() async {
    var dataCashflow = await CashflowTransaction.getLastMonthMapList();
    List<Chart> dataChartIncome = [Chart()];
    List<Chart> dataChartExpense = [Chart()];
    if (dataCashflow.isNotEmpty) {
      dataChartIncome = dataCashflow[0];
      dataChartExpense = dataCashflow[1];
    }
    return [
      charts.Series<Chart, DateTime>(
        id: 'income',
        data: dataChartIncome,
        seriesColor: charts.Color.fromHex(code: "#4CAF50"),
        domainFn: (Chart chart, _) => chart.date,
        measureFn: (Chart chart, index) => chart.value,
      ),
      charts.Series<Chart, DateTime>(
        id: 'expense',
        data: dataChartExpense,
        seriesColor: charts.Color.fromHex(code: "#F44336"),
        domainFn: (Chart chart, _) => chart.date,
        measureFn: (Chart chart, index) => chart.value,
      ),
    ];
  }

  Future<void> refreshData() async {
    var data = await CashflowTransaction.getSummaryMonth();
    income.value = curr.format(data['income']);
    expense.value = curr.format(data['expense']);
    dataChart.value = await getDataChart();
  }

  @override
  void onReady() async {
    super.onReady();
    await refreshData();
    // var dataIncome = await CashflowTransaction.getLastMonthList(1);
    // var dataOutcome = await CashflowTransaction.getLastMonthList(2);
  }
}
