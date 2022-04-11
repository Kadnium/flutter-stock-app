import 'package:flutter_stonks/constants.dart';
import 'package:flutter_stonks/helpers/api/base_api.dart';
import 'package:flutter_stonks/helpers/api/stock_api.dart';
import 'package:flutter_stonks/helpers/api/yahoo_parser.dart';
import 'package:flutter_stonks/models/chart_data_model.dart';
import 'package:flutter_stonks/models/stock_model.dart';

class YahooApi extends BaseApi implements StockApi {
  YahooApi({String route = ""}) : super(route);
  YahooParser yahooParser = YahooParser();
  @override
  Future<List<Stock>> getByTickerNames(List<String> tickers) async {
    Map<String, String> params = {
      "formatted": "true",
      "lang": "en-US",
      "region": "US",
      "symbols": tickers.join(","),
      "fields": [
        "shortName",
        "longName",
        "regularMarketPrice",
        "regularMarketChange",
        "regularMarketChangePercent",
        "postMarketPrice",
        "preMarketPrice",
        "postMarketChangePercent",
        "preMarketChangePercent"
      ].join(","),
    };

    String url = "https://query1.finance.yahoo.com/v7/finance/quote";
    dynamic result = await get(url, params);
    Map<String, dynamic> parsed = parseResponse(result);

    return yahooParser.parseTickerNameData(parsed);
  }

  @override
  Future<List<Stock>> getDailyGainers({int count = 1}) async {
    Map<String, String> params = {
      "formatted": "false",
      "lang": "en-US",
      "region": "US",
      "scrIds": "day_gainers",
      "count": count.toString()
    };

    String url =
        "https://query1.finance.yahoo.com/v1/finance/screener/predefined/saved";
    dynamic result = await get(url, params);
    Map<String, dynamic> parsed = parseResponse(result);
    return yahooParser.parseDailyMovers(parsed);
  }

  @override
  Future<List<Stock>> getDailyLosers({int count = 1}) async {
    Map<String, String> params = {
      "formatted": "false",
      "lang": "en-US",
      "region": "US",
      "scrIds": "day_losers",
      "count": count.toString()
    };

    String url =
        "https://query1.finance.yahoo.com/v1/finance/screener/predefined/saved";
    dynamic result = await get(url, params);
    Map<String, dynamic> parsed = parseResponse(result);

    return yahooParser.parseDailyMovers(parsed);
  }

  @override
  Future<List<Stock>> getDailyMovers({int count = 1}) async {
    List<Stock> dailyGainers = await getDailyGainers();
    List<Stock> dailyLosers = await getDailyLosers();

    return [...dailyGainers, ...dailyLosers];
  }



  @override
  Future<List<Stock>> getSearchResults(String query, {int count = 5}) async {
    Map<String, String> params = {
      "newsCount": "0",
      "enableFuzzyQuery": "false",
      "enableEnhancedTrivialQuery": "true",
      "region": "US",
      "lang": "en-US",
      "q": query,
      "quotesCount": count.toString()
      //"corsDomain":"finance.yahoo.com"
    };
    //newsCount=0&enableFuzzyQuery=false&enableEnhancedTrivialQuery=true&region=US&lang=en-US&q="+query+"&quotesCount="+count.toString();
    String url =
        "https://query2.finance.yahoo.com/v1/finance/search"; //?newsCount=0&enableFuzzyQuery=false&enableEnhancedTrivialQuery=true&region=US&lang=en-US&q="+query+"&quotesCount="+count.toString();
    dynamic result = await get(url, params);
    Map<String, dynamic> parsed = parseResponse(result);
    List<dynamic> quotes = parsed["quotes"];
    List<String> tickers = [];
    for (var quote in quotes) {
      tickers.add(quote["symbol"]);
    }

    return tickers.isEmpty ? Future.value([]) : getByTickerNames(tickers);
  }

  @override
  Future<List<Stock>> getTrendingTickers({int count = 5}) async {
    Map<String, String> params = {"count": count.toString()};
    //newsCount=0&enableFuzzyQuery=false&enableEnhancedTrivialQuery=true&region=US&lang=en-US&q="+query+"&quotesCount="+count.toString();
    String url =
        "https://query1.finance.yahoo.com/v1/finance/trending/US"; //?newsCount=0&enableFuzzyQuery=false&enableEnhancedTrivialQuery=true&region=US&lang=en-US&q="+query+"&quotesCount="+count.toString();
    dynamic result = await get(url, params);
    Map<String, dynamic> parsed = parseResponse(result);
    List<dynamic> quotes = [];
    if (parsed["finance"]["result"] != null) {
      quotes = parsed["finance"]["result"][0]["quotes"];
    }
    List<String> tickers = [];
    for (var quote in quotes) {
      tickers.add(quote["symbol"]);
    }

    return tickers.isEmpty ? Future.value([]) : getByTickerNames(tickers);
  }

  @override
  Future<List<Stock>> getStockIndexData() async {
    List<Stock> data = await getByTickerNames(kIndexData.keys.toList());
    for (Stock s in data) {
      if (kIndexData[s.symbol] != null) {
        s.name = kIndexData[s.symbol]!;
      }
    }
    return data;
  }

  @override
  Future<ChartData> getChartData(String symbol, List<String> interval) async {
    Map<String, String> params = {
      "symbol": symbol,
      "interval": interval[0],
      "range": interval[1],
      "includePrePost": "false",
      "region": "US",
      "lang": "en-US",

      //"corsDomain":"finance.yahoo.com"
    };
    ////AMD?symbol=AMD&useYfid=true&interval=5m&includePrePost=true&events=div%7Csplit%7Cearn&lang=en-US&region=US
    String url = "https://query1.finance.yahoo.com/v8/finance/chart/" + symbol;
    dynamic response = await get(url, params);
    Map<String, dynamic> chartData = parseResponse(response);

    return yahooParser.parseChartData(chartData);
  }

  @override
  Future<List<Stock>> updateStockList(List<Stock> stocks) async {
    List<String> tickers = [];
    for (Stock s in stocks) {
      tickers.add(s.symbol);
    }
    List<Stock> fetchedResults = await getByTickerNames(tickers);
    for (Stock s in stocks) {
      int index =
          fetchedResults.indexWhere((element) => element.symbol == s.symbol);

      if (index != -1) {
        Stock fs = fetchedResults[index];
        s.updatePriceData(fs);
      }
    }
    return stocks;
  }
}
