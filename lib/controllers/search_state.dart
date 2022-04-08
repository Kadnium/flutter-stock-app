

import 'package:flutter/material.dart';
import 'package:flutter_stonks/models/stock_model.dart';

class SearchState extends ChangeNotifier{
  String searchQuery = "";
  String lastQuery = "";
  
  List<Stock> searchResults= [];



  void onSearchChange(String query){
    searchQuery = query;
    notifyListeners();
  }


  void setSearchResults(List<Stock> results){
    searchResults = results;
    notifyListeners();

  }
}