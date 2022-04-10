import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:provider/provider.dart';

class FavouritesContainer extends HookWidget {
  FavouritesContainer({Key? key}) : super(key: key);
  final YahooApi yahooApi = YahooApi();
  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    StockDataState sState = context.watch<StockDataState>();
    List<Stock> favouriteList = sState.favouriteList;

    useEffect(() {
      if (!sState.favouritesInitialFetched && favouriteList.isNotEmpty) {
        isLoading.value = true;
        yahooApi.updateStockList(favouriteList).then((stocks) {
          context.read<StockDataState>().setFavouriteData(stocks);
          sState.favouritesInitialFetched = true;
        }).catchError((err) {
          print(err);
        }).whenComplete(() => isLoading.value = false);
      }
      return null;
    }, []);
    return Stack(
      alignment: Alignment.center,
      children: [
        StockContainer(title: "Suosikit", data: favouriteList),
        isLoading.value ? const AppSpinner() : const SizedBox()
      ],
    );
  }
}
