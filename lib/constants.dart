import 'package:flutter/foundation.dart';

const kBaseUrl = ""; //"http://192.168.0.4:3000/api";
const kUseAuth = false;
const kStockApi = StockApiDatasource.yahoo;

bool isMobile() {
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}



const Map<String, String> kIndexData = {
  "^GSPC": "S&P 500",
  "^DJI": "DOW 30",
  "^IXIC": "NASDAQ",
  "^RUT": "Russell 2000",
  "CL=F": "Oil",
  "GC=F": "Gold",
  "SI=F": "Silver",
  "EURUSD=X": "EUR/USD",
  "^TNX": "10-Yr Bond",
  "GBPUSD=X": "GBP/USD",
  "JPY=X": "USD/JPY",
  "BTC-USD": "Bitcoin",
  "^CMC200": "CMC Crypto",
  "^FTSE": "FTSE 100",
  "^N225": "Nikkei 225"
};

const Map<String, List<String>> kChartSettings = {
  "1d": ["5m", "1d"],
  "5d": ["30m", "5d"],
  "1m": ["1d", "1mo"],
  "6m": ["1d", "6mo"],
  "ytd": ["1d", "ytd"],
  "1y": ["1d", "1y"],
  "5y": ["1wk", "5y"],
  "all": ["1mo", "max"],
};

List<String> kChartSettingList = kChartSettings.keys.toList();

enum ChartType { candle, line }

// Maybe support more api's in the future
enum StockApiDatasource {yahoo}
