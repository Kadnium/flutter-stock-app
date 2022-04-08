import 'package:flutter_stonks/models/stock_model.dart';
import 'package:interactive_chart/interactive_chart.dart';

class YahooParser {
  bool hasKeys(Map<String, dynamic> json, List<String> keys) {
    for (var key in keys) {
      if (!json.containsKey(key)) {
        return false;
      }
    }
    return true;
  }

  bool isDataValid(List<dynamic> listOfLists, int index) {
    for (var list in listOfLists) {
      if (list[index] == "null" || list[index] == null) {
        return false;
      }
    }
    return true;
  }

  List<CandleData> parseChartData(Map<String, dynamic> json) {
    Map<String, dynamic>? meta = json["chart"]["result"][0];
    List<CandleData> candles = [];
    if (meta != null) {
      List<dynamic> timestamps = meta["timestamp"];
      Map<String, dynamic> inds = meta["indicators"]["quote"][0];
      List<dynamic> close = inds["close"];
      List<dynamic> open = inds["open"];
      List<dynamic> high = inds["high"];
      List<dynamic> volume = inds["volume"];
      List<dynamic> low = inds["low"];
      for (int i = 0; i < timestamps.length; i++) {
        if (isDataValid([close, open, high, volume, low, timestamps], i)) {
          //if(i<close.length && i<open.length && i<high.length && i<volume.length&& i<low.length){
          double vol = volume[i].toDouble();
          if(vol == 0.0){
            vol = 1;
          }
          candles.add(CandleData(
              timestamp: timestamps[i]*1000,
              high: high[i],
              low: low[i],
              open: open[i],
              close: close[i],
              volume:vol));
        }
      }
    }
    return candles;
  }

  List<Stock> parseTickerNameData(Map<String, dynamic> json) {
    List<Stock> returnArr = [];
    List<dynamic> quotesArr = json["quoteResponse"]["result"];
    for (var quote in quotesArr) {
      if (hasKeys(quote, [
        "symbol",
        "fullExchangeName",
        "shortName",
        "regularMarketPrice",
        "regularMarketChangePercent"
      ])) {
        double marketPrice = quote["regularMarketPrice"]["raw"] ?? 0;
        double marketChangePercent =
            quote["regularMarketChangePercent"]["raw"] ?? 0;
        double previousClose = quote["regularMarketPreviousClose"]["raw"] ?? 0;

        Stock stock = Stock(
            symbol: quote["symbol"],
            market: quote["fullExchangeName"],
            name: quote["shortName"],
            marketChange: marketChangePercent,
            marketPrice: marketPrice,
            isFavourite: false,
            previousClose: previousClose);

        if (hasKeys(quote, ["postMarketPrice", "postMarketChangePercent"])) {
          stock.extendedHoursChange =
              quote["postMarketChangePercent"]["raw"] ?? 0;
          stock.extendedHoursPrice = quote["postMarketPrice"]["raw"] ?? 0;
        } else if (hasKeys(
            quote, ["preMarketPrice", "preMarketChangePercent"])) {
          stock.extendedHoursChange =
              quote["preMarketChangePercent"]["raw"] ?? 0;
          stock.extendedHoursPrice = quote["preMarketPrice"]["raw"] ?? 0;
        }

        if (hasKeys(quote, ["marketState"])) {
          stock.setMarketState(quote["marketState"]);
        }

        returnArr.add(stock);
      }
    }
    return returnArr;
  }

  List<Stock> parseDailyMovers(Map<String, dynamic> json) {
    List<Stock> returnArr = [];
    List<dynamic> quotesArr = json["finance"]["result"][0]["quotes"];
    for (var quote in quotesArr) {
      if (hasKeys(quote, [
        "symbol",
        "fullExchangeName",
        "shortName",
        "regularMarketPrice",
        "regularMarketChangePercent",
        "regularMarketPreviousClose"
      ])) {
        Stock stock = Stock(
            symbol: quote["symbol"],
            market: quote["fullExchangeName"],
            name: quote["shortName"],
            marketChange: quote["regularMarketChangePercent"],
            marketPrice: quote["regularMarketPrice"],
            isFavourite: false,
            previousClose: quote["regularMarketPreviousClose"]);

        if (hasKeys(quote, ["postMarketPrice", "postMarketChangePercent"])) {
          stock.extendedHoursChange = quote["postMarketChangePercent"];
          stock.extendedHoursPrice = quote["postMarketPrice"];
        } else if (hasKeys(
            quote, ["preMarketPrice", "preMarketChangePercent"])) {
          stock.extendedHoursChange = quote["preMarketChangePercent"];
          stock.extendedHoursPrice = quote["preMarketPrice"];
        }

        if (hasKeys(quote, ["marketState"])) {
          stock.setMarketState(quote["marketState"]);
        }

        returnArr.add(stock);
      }
    }
    return returnArr;
  }
}