import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logcashflow/app/data/helper/currency.dart';
import 'package:logcashflow/app/data/models/cashflow.dart';

class CasflowItem extends StatelessWidget {
  final Cashflow cashflow;

  const CasflowItem({Key? key, required this.cashflow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var symbol = "+";
    var color = Colors.green;
    var icon = Icons.arrow_back_ios_new_rounded;
    if (cashflow.type == 2) {
      symbol = "-";
      color = Colors.red;
      icon = Icons.arrow_forward_ios_rounded;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "[ $symbol ] ${curr.format(cashflow.value)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: (cashflow.type == 1) ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              cashflow.description,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              DateFormat.yMMMMEEEEd().format(cashflow.date),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        Icon(
          icon,
          color: color,
          size: 60,
        )
      ],
    );
  }
}
