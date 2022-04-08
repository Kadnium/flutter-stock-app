

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:provider/provider.dart';

class FavouritesContainer extends HookWidget {
  FavouritesContainer({ Key? key }) : super(key: key);
  final YahooApi yahooApi = YahooApi();
  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    List<Stock> favouriteList = context.watch<StockDataState>().favouriteList; 

    // useEffect((){
    //   if(mostChanged.isEmpty){
    //     isLoading.value = true;
    //     yahooApi.getTrendingTickers().then((stocks){
    //       context.read<StockDataState>().setMostChangedData(stocks);
    //     }).catchError((err){
    //       print(err);
    //     }).whenComplete(() => isLoading.value = false);
    //   }
    //   return null;
    // },[]);
    return Stack(
      alignment: Alignment.center,
      children: [
        StockContainer(title: "Suosikit", data:favouriteList),
        isLoading.value?const AppSpinner():const SizedBox()
      ],
    );
      
    
  }
}
