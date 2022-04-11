import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/models/chart_candle_model.dart';
import 'package:flutter_stonks/screens/chart/components/chart_info_helper.dart';

class CustomCandleChart extends HookWidget {
  const CustomCandleChart(
      {Key? key,
      required this.data,
      required this.onTimeFrameChange,
      required this.change,
      required this.onRefreshClick})
      : super(key: key);
  final List<CustomChartCandle> data;
  final Function(String?) onTimeFrameChange;
  final double change;
  final Function() onRefreshClick;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        ChartInfoHelper(
          onRefreshClick: onRefreshClick,
          onTimeFrameChange: onTimeFrameChange,
          change: change,
        ),
        Expanded(
            child: Candlesticks(
          candles: data.reversed.toList(),
          chartAdjust: ChartAdjust.fullRange,
          displayZoomActions: false,
          loadingWidget: const AppSpinner(),
        )),
      ],
    ));
  }
}
