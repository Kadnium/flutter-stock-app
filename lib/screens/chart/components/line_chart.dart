import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/models/chart_candle_model.dart';
import 'package:flutter_stonks/screens/chart/components/chart_info_helper.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomLineChart extends HookWidget {
  const CustomLineChart(
      {Key? key,
      required this.data,
      required this.onTimeFrameChange,
      required this.onRefreshClick,
      required this.change})
      : super(key: key);
  final List<CustomChartCandle> data;
  final double change;
  final Function(String?) onTimeFrameChange;
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
          child: data.isEmpty
              ? const Center(child: AppSpinner())
              : SfCartesianChart(
                  //plotAreaBorderColor: Colors.green,
                  //plotAreaBackgroundColor: Colors.green,
                  //title: ChartTitle(text: 'AAPL - 2016'),
                  // zoomPanBehavior: ZoomPanBehavior(
                  //   zoomMode: ZoomMode.x,
                  //   enablePinching: true,
                  //   enableMouseWheelZooming: true,
                  //   enablePanning: true,
                  // ),
                  legend: Legend(isVisible: false),
                  trackballBehavior: TrackballBehavior(
                      enable: true,
                      activationMode: ActivationMode.longPress,
                      builder: (context, tb) {
                        num price = tb.point?.y ?? 0;
                        DateTime? x = tb.point?.x;

                        return Container(
                          height: 60,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Price: " +
                                      NumberFormat.simpleCurrency()
                                          .format(price),
                                ),
                                if (x != null)
                                  Text(DateFormat("dd.MM.yyyy HH:mm").format(x))
                              ],
                            ),
                          ),
                        );
                      }),

                  series: <ChartSeries>[
                    AreaSeries<CustomChartCandle, DateTime>(
                        borderColor: change >= 0 ? Colors.green : Colors.red,
                        borderWidth: 2,
                        color: change >= 0
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        dataSource: data,
                        xValueMapper: (CustomChartCandle candle, _) =>
                            candle.date,
                        yValueMapper: (CustomChartCandle candle, _) =>
                            candle.close)
                  ],
                  primaryXAxis: DateTimeCategoryAxis(
                      interval: 15,
                      //dateFormat: DateFormat("dd.MM.yyyy HH:mm"),
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      opposedPosition: true,
                      //minimum: 70,
                      //maximum: 130,
                      //interval: 5,
                      majorGridLines: const MajorGridLines(width: 0),
                      //interval: 10,
                      numberFormat:
                          NumberFormat.simpleCurrency(decimalDigits: 0)),
                ),
        ),
      ],
    ));
  }
}
