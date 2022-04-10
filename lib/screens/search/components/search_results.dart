import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:provider/provider.dart';

class SearchResults extends HookWidget {
  SearchResults({Key? key}) : super(key: key);
  YahooApi api = YahooApi();

  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    //var searchResults = useState<List<Stock>>([]);
    SearchState searchState =
        context.watch<SearchState>(); //((SearchState s) => s.searchQuery);

    String queryString = searchState.searchQuery;

    useEffect(() {
      if (queryString.isNotEmpty &&
          context.read<SearchState>().lastQuery != queryString) {
        isLoading.value = true;
        api.getSearchResults(queryString).then((stocks) {
          searchState.setSearchResults(
              context.read<StockDataState>().checkIfFavourite(stocks));
          searchState.lastQuery = queryString;
        }).catchError((err) {
          print(err);
        }).whenComplete(() => isLoading.value = false);
      }
    }, [queryString]);

    return Stack(
      alignment: Alignment.center,
      children: [
        StockContainer(title: "Hakutulokset", data: searchState.searchResults),
        isLoading.value ? const AppSpinner() : const SizedBox()
      ],
    );
  }
}
