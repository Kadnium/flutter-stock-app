import 'package:flutter/material.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/components/market_change_text.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:flutter_stonks/routes.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class StockIndexInfo extends StatelessWidget {
  const StockIndexInfo({Key? key, required this.stock}) : super(key: key);
  final Stock stock;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 5,
      child: InkWell(
        onTap: () {
          context.read<StockDataState>().setClickedStock(stock);
          Routemaster.of(context).push(AppRoutes.chart + "/" + stock.symbol);
        },
        child: SizedBox(
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                stock.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(stock.marketPrice.toString()),
              MarketChangeText(marketChange: stock.marketChange)
            ],
          ),
        ),
      ),
    );
  }
}
