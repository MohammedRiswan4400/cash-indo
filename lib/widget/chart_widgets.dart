import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> paiChartDatas(bool isDebt) {
  return [
    PieChartSectionData(
      color: isDebt ? Colors.redAccent : Colors.green,
      value: 90,
      title: '',
      radius: 90,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      color: Colors.transparent,
      value: 30,
      title: '',
      radius: 90,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ];
}
