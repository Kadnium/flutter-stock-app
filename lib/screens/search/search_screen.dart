import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/screens/search/components/search_field.dart';
import 'package:flutter_stonks/screens/search/components/search_results.dart';
import 'package:flutter_stonks/screens/search/components/trending_container.dart';
import 'package:provider/provider.dart';

class SearchScreen extends HookWidget {
  SearchScreen({Key? key}) : super(key: key);
  final YahooApi yahooApi = YahooApi();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return yahooApi.getTrendingTickers().then((value) {
          context.read<StockDataState>().setTrendingData(value);
        }).catchError((err) {
          print(err);
        });
      },
      child: ListView(
        children: [
          SearchField(
              onChange: (val) {
                context.read<SearchState>().onSearchChange(val);
                //textState.value = val;
                //print(val);
              },
              label: "Haku"),
          const SizedBox(height: 50),
          SearchResults(),
          const SizedBox(height: 25),
          TrendingContainer(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
