import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:logcashflow/app/modules/home/controllers/home_controller.dart';

class LineChartWidget extends StatelessWidget {
  final HomeController controller;
  const LineChartWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          padding:
              const EdgeInsets.only(top: 32, bottom: 10, right: 18, left: 6),
          child: Obx(
            () => LineChart(
              LineChartData(
                borderData: FlBorderData(
                  border: Border(
                    left: borderTheme(),
                    bottom: borderTheme(),
                    top: borderTheme(),
                    right: borderTheme(),
                  ),
                ),
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(DateFormat.MMMM()
                        .format(controller.bottomAxis.value)
                        .toString()),
                    axisNameSize: 24,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      interval: 7,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(NumberFormat.currency().currencyName!),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,
                    ),
                  ),
                ),
                lineBarsData: controller.dataChartFl.value,
                minX: 1,
                maxX: DateTime(controller.bottomAxis.value.year,
                        controller.bottomAxis.value.month + 1, 0)
                    .day
                    .toDouble(),
                minY: 0,
                maxY: controller.maxY.value,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: controller.colorBorder.value,
                      strokeWidth: 1,
                    );
                  },
                  // getDrawingVerticalLine: (value) {
                  //   return FlLine(
                  //     color: const Color(0xff37434d),
                  //     strokeWidth: 1,
                  //   );
                  // },
                ),
              ),
              swapAnimationDuration: const Duration(milliseconds: 500),
              swapAnimationCurve: Curves.decelerate,
            ),
          ),
        ),
      ),
    );
  }

  BorderSide borderTheme() {
    return BorderSide(
      color: controller.colorBorder.value,
    );
  }
}
