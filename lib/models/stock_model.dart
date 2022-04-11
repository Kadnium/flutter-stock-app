enum MarketState {
  pre,
  regular,
  post,
}

class Stock {
  final String symbol;
  String market;
  String name;
  double marketChange;
  double marketPrice;
  bool isFavourite;
  double previousClose;
  double? extendedHoursPrice;
  double? extendedHoursChange;
  MarketState marketState;

  Stock(
      {required this.symbol,
      required this.market,
      required this.name,
      required this.marketChange,
      required this.marketPrice,
      required this.isFavourite,
      required this.previousClose,
      this.extendedHoursPrice,
      this.extendedHoursChange,
      this.marketState = MarketState.regular});

  void setMarketState(String state) {
    if (state == "PRE") {
      marketState = MarketState.pre;
      // "Yahoo has also state PREPRE"
    } else if (state.contains("POST") || state.contains("CLOSED") || state.contains("PRE")) {
      marketState = MarketState.post;
    } else {
      marketState = MarketState.regular;
    }
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
        symbol: json["symbol"],
        market: json["market"],
        name: json["name"],
        marketChange: json["marketChange"],
        marketPrice: json["marketPrice"],
        isFavourite: json["isFavourite"],
        previousClose: json["previousClose"],
        extendedHoursPrice: json["extendedHoursPrice"],
        extendedHoursChange: json["extendedHoursChange"],
        marketState: MarketState.values.elementAt(json["marketState"]));
  }

  static Map<String, dynamic> toJson(Stock stock) {
    return {
      "symbol": stock.symbol,
      "market": stock.market,
      "name": stock.name,
      "marketChange": stock.marketChange,
      "marketPrice": stock.marketPrice,
      "isFavourite": stock.isFavourite,
      "previousClose": stock.previousClose,
      "extendedHoursPrice": stock.extendedHoursPrice,
      "extendedHoursChange": stock.extendedHoursChange,
      "marketState": stock.marketState.index
    };
  }

  void updatePriceData(Stock source) {
    marketChange = source.marketChange;
    marketPrice = source.marketPrice;
    previousClose = source.previousClose;
    extendedHoursChange = source.extendedHoursChange;
    extendedHoursPrice = source.extendedHoursPrice;
    marketState = source.marketState;
  }
}
