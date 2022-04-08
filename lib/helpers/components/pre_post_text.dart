import 'package:flutter/material.dart';
import 'package:flutter_stonks/models/stock_model.dart';

class PrePostText extends StatelessWidget {
  const PrePostText({Key? key, required this.stock})
      : super(key: key);
  final Stock stock;
  @override
  Widget build(BuildContext context) {
    if(stock.marketState == MarketState.regular){
      return const SizedBox();
    }
    double extChange = stock.extendedHoursChange ?? 0;
    String prePostText = stock.marketState == MarketState.pre ?"Pre ":"Post ";
    return RichText(text: TextSpan(
      text: prePostText,
      children:  [
        TextSpan(text:extChange.toStringAsFixed(2) + "%",style: TextStyle(color: extChange >= 0 ? Colors.green : Colors.red))
      ]
    ));
   
  }
}
