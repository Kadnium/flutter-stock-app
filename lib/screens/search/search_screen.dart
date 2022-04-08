import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/screens/search/components/search_field.dart';
import 'package:flutter_stonks/screens/search/components/search_results.dart';
import 'package:flutter_stonks/screens/search/components/trending_container.dart';
import 'package:provider/provider.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SearchField(onChange: (val) {
            context.read<SearchState>().onSearchChange(val);
            //textState.value = val;
            //print(val);
            
          },label: "Haku"),
        const SizedBox(height: 50),
        SearchResults(),
        const SizedBox(height: 25),
        TrendingContainer(),
         const SizedBox(height: 25),
      ],
    );
  }
}
