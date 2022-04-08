import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/constants.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/helpers/components/simple_dropdown_button.dart';
import 'package:flutter_stonks/helpers/components/stock_info.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_chart/interactive_chart.dart';
import 'package:provider/provider.dart';

class ChartScreen extends HookWidget {
  ChartScreen({Key? key, required this.symbol}) : super(key: key);
  final String? symbol;
  final YahooApi yahooApi = YahooApi();

  @override
  Widget build(BuildContext context) {
    var candleData = useState<List<Candle>>([]);
    var chartSetting = useState<String>(kChartSettings.keys.toList()[1]);
    useEffect(() {
      // if(symbol != null){
      // fetchCandles().then((value){
      //   candleData.value = value;
      // }).catchError((err){
      //   print(err);
      // });
      List<String> args = kChartSettings[chartSetting.value] ?? ["15m", "5d"];
      yahooApi.getChartData(symbol!, args).then((value) {
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
          child: Candlesticks(
            actions: [
              ToolBarAction(
                  width: 60,
                  child: SimpleDropdownButton(
                    initialValue: chartSetting.value,
                    data: kChartSettings.keys.toList(),
                    onChange: (value) {
                      if (value != null) {
                        chartSetting.value = value;
                      }
                    },
                  ),
                  onPressed: () {
                    print("a");
                  })
            ],
            candles: candleData.value,
          ),
        ),
      ],
    );
  }
}
