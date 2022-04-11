import 'package:flutter_stonks/constants.dart';
import 'package:flutter_stonks/helpers/api/stock_api.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';

class ApiService {
  ApiService._privateConstructor(this._stockApi);

  static StockApi _setStockApi() {
    switch (kStockApi) {
      case StockApiDatasource.yahoo:
        return YahooApi();
      default:
        return YahooApi();
    }
  }

  StockApi _stockApi;
  static final ApiService _instance =
      ApiService._privateConstructor(_setStockApi());

  StockApi get stockApi => _stockApi;

  factory ApiService() {
    return _instance;
  }
}
