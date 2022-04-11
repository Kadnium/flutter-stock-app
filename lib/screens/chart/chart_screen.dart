
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/constants.dart';
import 'package:flutter_stonks/controllers/app_state.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/api_service.dart';
import 'package:flutter_stonks/helpers/components/stock_info.dart';
import 'package:flutter_stonks/models/chart_data_model.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:flutter_stonks/screens/chart/components/candle_chart.dart';
import 'package:flutter_stonks/screens/chart/components/line_chart.dart';

import 'package:provider/provider.dart';

class ChartScreen extends HookWidget {
  const ChartScreen({Key? key, required this.symbol}) : super(key: key);
  final String? symbol;
  Future<ChartData?> getChartData(String? symbol, String timeframe) {
    if (symbol == null) return Future.value(null);
    List<String> args = kChartSettings[timeframe] ?? ["3m", "1d"];
    return ApiService().stockApi.getChartData(symbol, args);
  }

  @override
  Widget build(BuildContext context) {
    var candleData = useState<ChartData?>(null);
    var chartSetting = useState<String>(kChartSettingList[0]);
    useEffect(() {
      getChartData(symbol, chartSetting.value).then((value) {
        candleData.value = value;
      }).catchError((err) {
        print(err);
      });
      return null;
    }, [symbol, chartSetting.value]);
    Stock? clickedStock = context.watch<StockDataState>().clickedStock;
    return Column(
      children: [
        if (clickedStock != null)
          SizedBox(child: StockInfo(stock: clickedStock, disableOnClick: true)),
        Expanded(
          child: context.select((AppState a) => a.lineChart)
              ? CustomLineChart(
                  onRefreshClick: () {
                    getChartData(symbol, chartSetting.value).then((value) {
                      candleData.value = value;
                    }).catchError((err) {
                      print(err);
                    });
                  },
                  data: candleData.value?.chartData ?? [],
                  change: candleData.value?.change ?? 0,
                  onTimeFrameChange: (val) {
                    if (val != null) {
                      chartSetting.value = val;
                    }
                  },
                )
              : CustomCandleChart(
                  onRefreshClick: () {
                    getChartData(symbol, chartSetting.value).then((value) {
                      candleData.value = value;
                    }).catchError((err) {
                      print(err);
                    });
                  },
                  data: candleData.value?.chartData ?? [],
                  change: candleData.value?.change ?? 0,
                  onTimeFrameChange: (val) {
                    if (val != null) {
                      chartSetting.value = val;
                    }
                  },
                ),
        )
      ],
    );
  }
}
