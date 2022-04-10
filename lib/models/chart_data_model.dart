import 'package:flutter_stonks/models/chart_candle_model.dart';
import 'package:flutter/material.dart';

class ChartData {
  List<CustomChartCandle> chartData;
  double change = 0;
  double previousChartClose;

  ChartData({required this.chartData, required this.previousChartClose}) {
    if (chartData.length > 1 &&
        chartData.last.close != 0 &&
        previousChartClose != 0) {
      change = (chartData.last.close / previousChartClose * 100 - 100);
    }
  }
}
