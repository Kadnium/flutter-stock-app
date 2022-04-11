import 'package:flutter/material.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/api_service.dart';
import 'package:flutter_stonks/helpers/api/stock_api.dart';
import 'package:flutter_stonks/screens/home/components/favourites_container.dart';
import 'package:flutter_stonks/screens/home/components/most_changed_container.dart';
import 'package:flutter_stonks/screens/home/components/stock_index_container.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        StockApi stockApi = ApiService().stockApi;
        StockDataState s = context.read<StockDataState>();
        return stockApi.getStockIndexData().then((value) {
          s.setStockIndexData(s.checkIfFavourite(value));
          return stockApi.getDailyMovers();
        }).then((value) {
          s.setMostChangedData(s.checkIfFavourite(value));
          return stockApi.updateStockList(s.favouriteList);
        }).then((value) {
          s.setFavouriteData(value);
        }).catchError((err) {
          print(err);
        });
      },
      child: SizedBox(
        width: double.infinity,
        child: ListView(scrollDirection: Axis.vertical, children: const [
           SizedBox(
            height: 5,
          ),
          StockIndexContainer(),
           SizedBox(
            height: 25,
          ),
          MostChangedContainer(),
           SizedBox(
            height: 50,
          ),
           FavouritesContainer(),
           SizedBox(height: 25),
        ]),
      ),
    );
  }
}
