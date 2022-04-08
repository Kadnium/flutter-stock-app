
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:interactive_chart/interactive_chart.dart';

abstract class StockApiInterface {
  Future<List<CandleData>> getChartData(String symbol, List<String> interval);
  Future<List<Stock>> getStockIndexData();
  Future<List<Stock>> getTrendingTickers({int count = 5});
  Future<List<Stock>> getSearchResults(String query, {int count = 5});
  Future<List<Stock>> getFrontPageSymbols();
  Future<List<Stock>> getDailyGainers({int count = 1});
  Future<List<Stock>> getDailyLosers({int count = 1 });
  Future<List<Stock>> getDailyMovers({int count = 1});
  Future<List<Stock>> getByTickerNames(List<String> tickers);
  


}