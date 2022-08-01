import 'package:logcashflow/app/data/database/db_helper.dart';
import 'package:logcashflow/app/data/models/cashflow.dart';
import 'package:logcashflow/app/data/models/chart.dart';

class CashflowTransaction {
  static String _querySummary(String column, int id) {
    var query =
        "SELECT $column FROM cashflow WHERE type = $id AND date >= date('now','start of month') ORDER BY date DESC";
    return query;
  }

  static const String _tableName = "cashflow";
  static Future<int> addCashflow(Cashflow cashflow) {
    var db = DbHelper();
    return db.insert(_tableName, cashflow.toMap());
  }

  static Future<List<Cashflow>> getAllData() async {
    var db = DbHelper();
    var query = "SELECT * FROM cashflow ORDER BY date DESC";
    var listRes = await db.selectQuery(query);
    return listRes.map((e) => Cashflow.fromMap(e)).toList();
  }

  static Future<List<List<Chart>>> getLastMonthMapList() async {
    var db = DbHelper();
    var queryIncome = _querySummary("date, SUM(value) AS value", 1);
    var queryExpense = _querySummary("date, SUM(value) AS value", 2);
    queryIncome = queryIncome.replaceFirst(
        r'ORDER BY date DESC', 'GROUP BY date ORDER BY date desc');
    queryExpense = queryExpense.replaceFirst(
        r'ORDER BY date DESC', 'GROUP BY date ORDER BY date desc');
    var listResIncome = await db.selectQuery(queryIncome);
    var listResExpense = await db.selectQuery(queryExpense);
    return [
      listResIncome.map((e) => Chart.fromMap(e)).toList(),
      listResExpense.map((e) => Chart.fromMap(e)).toList()
    ];
  }

  static Future<Map<String, dynamic>> getSummaryMonth() async {
    var db = DbHelper();
    var column = "TOTAL(value) AS value";
    var queryIncome = _querySummary(column, 1);
    var queryExpense = _querySummary(column, 2);
    var query =
        "SELECT i.value as income, e.value as expense FROM ($queryIncome) AS i, ($queryExpense) AS e";
    var listRes = await db.selectQuery(query);
    if (listRes.isEmpty) {
      return {};
    }
    return listRes.first;
  }
}
