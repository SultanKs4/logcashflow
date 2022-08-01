import 'package:get/get.dart';
import 'package:logcashflow/app/data/database/cashflow_transaction.dart';
import 'package:logcashflow/app/data/models/cashflow.dart';

class DetailController extends GetxController {
  final listCashflow = <Cashflow>[].obs;

  @override
  void onReady() async {
    super.onReady();
    listCashflow.value = await CashflowTransaction.getAllData();
  }
}
