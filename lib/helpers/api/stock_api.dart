import 'package:flutter_stonks/models/chart_data_model.dart';
import 'package:flutter_stonks/models/stock_model.dart';

abstract class StockApi {
  Future<List<Stock>> updateStockList(List<Stock> stocks);
  Future<ChartData> getChartData(String symbol, List<String> interval);
  Future<List<Stock>> getStockIndexData();
  Future<List<Stock>> getTrendingTickers({int count = 5});
  Future<List<Stock>> getSearchResults(String query, {int count = 5});
  Future<List<Stock>> getDailyGainers({int count = 1});
  Future<List<Stock>> getDailyLosers({int count = 1});
  Future<List<Stock>> getDailyMovers({int count = 1});
  Future<List<Stock>> getByTickerNames(List<String> tickers);
}
