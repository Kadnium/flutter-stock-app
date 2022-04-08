

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/components/horizontal_stock_container.dart';
import 'package:provider/provider.dart';

class StockIndexContainer extends HookWidget {
  StockIndexContainer({ Key? key }) : super(key: key);
  YahooApi yahooApi = YahooApi();
  @override
  Widget build(BuildContext context) {
    StockDataState state = context.watch<StockDataState>();
    useEffect((){
      if(state.stockIndexList.isEmpty){
       
        yahooApi.getStockIndexData().then((stocks){
          context.read<StockDataState>().setStockIndexData(stocks);
        }).catchError((err){
          print(err);
        });
      }
      return null;
    },[]);
    return HorizontalStockContainer(data: state.stockIndexList);
  }
}