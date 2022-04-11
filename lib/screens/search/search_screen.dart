import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/api_service.dart';
import 'package:flutter_stonks/helpers/components/common_text_field.dart';
import 'package:flutter_stonks/screens/search/components/search_results.dart';
import 'package:flutter_stonks/screens/search/components/trending_container.dart';
import 'package:provider/provider.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return ApiService().stockApi.getTrendingTickers().then((value) {
          StockDataState s = context.read<StockDataState>();
          context.read<StockDataState>().setTrendingData(s.checkIfFavourite(value));
        }).catchError((err) {
          print(err);
        });
      },
      child: ListView(
        children: [
          CommonTextField(
              onChange: (val) {
                context.read<SearchState>().onSearchChange(val);
                //textState.value = val;
                //print(val);
              },
              label: "Haku"),
          const SizedBox(height: 50),
          const SearchResults(),
          const SizedBox(height: 25),
          const TrendingContainer(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
