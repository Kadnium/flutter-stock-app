
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


  Stock({
    required this.symbol,
    required this.market,
    required this.name,
    required this.marketChange,
    required this.marketPrice,
    required this.isFavourite,
    required this.previousClose,
    this.extendedHoursPrice,
    this.extendedHoursChange,
    this.marketState = MarketState.regular
    
  });


  void setMarketState(String state){
    if(state.contains("PRE")){
      marketState = MarketState.pre;
    }else if(state.contains("POST")){
      marketState = MarketState.post;
    }else{
      marketState = MarketState.regular;
    }
  }

  factory Stock.fromJson(Map<String,dynamic> json){
    return Stock(
      symbol: json["symbol"],
      market:json["market"],
      name:json["name"],
      marketChange:json["marketChange"],
      marketPrice: json["marketPrice"],
      isFavourite: json["isFavourite"],
      previousClose:json["previousClose"]
    );
  }




}