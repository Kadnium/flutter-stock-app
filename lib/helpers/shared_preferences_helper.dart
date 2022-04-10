import 'dart:convert';

import 'package:flutter_stonks/models/stock_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const kThemeMode = "STONKS_APP_THEME";
  static const kLineChart = "STONKS_LINE_CHART";
  static const kUserFavourites = "STONKS_FAVOURITES";

  static Future<bool> saveToPrefs(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<List<dynamic>?> getUserFavourites() async {
    String? val = await getStringFromPrefs(kUserFavourites);
    if (val != null) {
      return jsonDecode(val);
    }
    return null;
  }

  static Future<String?> getSavedToken() async {
    return "NONE";
  }

  static Future<bool> saveFavourites(List<Stock> favourites) async {
    String? encoded =
        jsonEncode(favourites.map((Stock s) => Stock.toJson(s)).toList());
    return saveToPrefs(kUserFavourites, encoded);
  }

  static Future<List<Stock>> getFavourites() async {
    String? value = await getStringFromPrefs(kUserFavourites);
    if (value != null) {
      List<dynamic> decoded = jsonDecode(value);
      return decoded.map((s) => Stock.fromJson(s)).toList();
    }
    return [];
  }

  static Future<bool> saveLineChart(bool status) async {
    return await saveToPrefs(kLineChart, status.toString());
  }

  static Future<bool> saveThemeMode(bool theme) async {
    return await saveToPrefs(kThemeMode, theme.toString());
  }

  static Future<bool> getThemeMode() async {
    String? val = await getStringFromPrefs(kThemeMode);
    return val == "true";
  }

  static Future<bool> getLineChart() async {
    String? val = await getStringFromPrefs(kLineChart);
    return val == "true";
  }

  static Future<bool> deleteFromPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<String?> getStringFromPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
