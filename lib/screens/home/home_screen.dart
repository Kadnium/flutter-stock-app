import 'package:flutter/material.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/components/horizontal_stock_container.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/routes.dart';
import 'package:flutter_stonks/screens/home/components/favourites_container.dart';
import 'package:flutter_stonks/screens/home/components/most_changed_container.dart';
import 'package:flutter_stonks/screens/home/components/stock_index_container.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final YahooApi yahooApi = YahooApi();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        StockDataState s = context.read<StockDataState>();
        return yahooApi.getStockIndexData().then((value) {
          s.setStockIndexData(value);
          return yahooApi.getDailyMovers();
        }).then((value) {
          s.setMostChangedData(value);
          return yahooApi.updateStockList(s.favouriteList);
        }).then((value) {
          s.setFavouriteData(value);
        }).catchError((err) {
          print(err);
        });
      },
      child: SizedBox(
        width: double.infinity,
        child: ListView(scrollDirection: Axis.vertical, children: [
          const SizedBox(
            height: 5,
          ),
          StockIndexContainer(),
          const SizedBox(
            height: 25,
          ),
          MostChangedContainer(),
          const SizedBox(
            height: 50,
          ),
          FavouritesContainer(),
          const SizedBox(height: 25),
        ]),
      ),
    );
  }
}
