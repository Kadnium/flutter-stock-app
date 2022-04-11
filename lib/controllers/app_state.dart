import 'package:flutter/material.dart';
import 'package:flutter_stonks/helpers/shared_preferences_helper.dart';

class AppState extends ChangeNotifier {
  AppState({this.darkTheme = false, this.lineChart = false});
  bool darkTheme = false;
  bool lineChart = false;

  void setDarkTheme(bool value) async {
    darkTheme = value;
    await SharedPreferencesHelper.saveThemeMode(value);
    notifyListeners();
  }

  void setLineChart(bool value) async {
    lineChart = value;
    await SharedPreferencesHelper.saveLineChart(value);
    notifyListeners();
  }
}
