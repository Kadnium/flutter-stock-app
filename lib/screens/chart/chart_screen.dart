import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_chart/interactive_chart.dart';

class ChartScreen extends HookWidget {
  ChartScreen({Key? key, required this.symbol}) : super(key: key);
  final String? symbol;
  final YahooApi yahooApi = YahooApi();


  @override
  Widget build(BuildContext context) {
    var candleData = useState<List<CandleData>>([]);
    useEffect(() {
      // if(symbol != null){
      // fetchCandles().then((value){
      //   candleData.value = value;
      // }).catchError((err){
      //   print(err);
      // });
      yahooApi.getChartData(symbol!, ["1d", "6mo"]).then((value) {
        candleData.value = value;
      }).catchError((err) {
        print(err);
      });
    }, [symbol]);

    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: candleData.value.isEmpty
            ? const AppSpinner()
            : InteractiveChart(candles: candleData.value));
    // return Center(
    //       child: Candlesticks(
    //         onLoadMoreCandles: () {
    //           print("LOAD");
    //           return Future.value();

    //         },
    //         candles: candleData.value,
    //       ));
  }
}
