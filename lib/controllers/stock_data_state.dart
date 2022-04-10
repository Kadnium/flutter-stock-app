import 'package:flutter/material.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/helpers/shared_preferences_helper.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:flutter_stonks/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

class StockDataState extends ChangeNotifier {
  List<Stock> mostChangedList = [];
  List<Stock> trendingList = [];
  List<Stock> favouriteList = [];
  List<Stock> stockIndexList = [];
  Stock? clickedStock;
  bool favouritesInitialFetched = false;

  StockDataState({required this.favouriteList});
  void setMostChangedData(List<Stock> data) {
    mostChangedList = data;
    notifyListeners();
  }

  void setClickedStock(Stock stock) {
    clickedStock = stock;
  }

  void setTrendingData(List<Stock> data) {
    trendingList = data;
    notifyListeners();
  }

  List<Stock> checkIfFavourite(List<Stock> listToCheck) {
    for (Stock s in listToCheck) {
      int index =
          favouriteList.indexWhere((element) => element.symbol == s.symbol);
      if (index != -1) {
        s.isFavourite = favouriteList[index].isFavourite;
      }
    }
    return listToCheck;
  }

  void setFavouriteData(List<Stock> data) {
    favouriteList = data;
    notifyListeners();
  }

  void setStockIndexData(List<Stock> data) {
    stockIndexList = data;
    notifyListeners();
  }

  void handleSetFavourite(Stock stock, BuildContext context) {
    int index =
        favouriteList.indexWhere((element) => element.symbol == stock.symbol);
    if (index == -1) {
      setFavourite(stock, context);
    } else {
      unFavourite(stock, index, context);
    }
    SharedPreferencesHelper.saveFavourites(favouriteList);
  }

  void setFavourite(Stock stock, BuildContext context) {
    stock.isFavourite = true;
    favouriteList.insert(0, stock);
    updateAllLists(stock, context);
    notifyListeners();
  }

  void unFavourite(Stock stock, int index, BuildContext context) {
    stock.isFavourite = false;
    favouriteList.removeAt(index);
    updateAllLists(stock, context);
    notifyListeners();
  }

  void setFavouritesOnList(List<Stock> list, Stock stock) {
    int index = list.indexWhere((element) => element.symbol == stock.symbol);
    if (index != -1) {
      list[index].isFavourite = stock.isFavourite;
    }
  }

  void updateAllLists(Stock stock, BuildContext context) {
    setFavouritesOnList(favouriteList, stock);
    setFavouritesOnList(mostChangedList, stock);
    setFavouritesOnList(trendingList, stock);
    if (clickedStock != null) {
      clickedStock!.isFavourite = stock.isFavourite;
    }
    List<Stock> searchResults = context.read<SearchState>().searchResults;
    setFavouritesOnList(searchResults, stock);
    context.read<SearchState>().setSearchResults(searchResults);
    //setFavouritesOnList(trendingList,stock);
  }
}
