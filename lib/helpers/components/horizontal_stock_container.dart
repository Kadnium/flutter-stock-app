import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/yahoo_api.dart';
import 'package:flutter_stonks/helpers/components/stock_index_info.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:provider/provider.dart';

class HorizontalStockContainer extends StatelessWidget {
  const HorizontalStockContainer({Key? key, required this.data})
      : super(key: key);
  final List<Stock> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        elevation: 5,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,

              // shrinkWrap: true,
              itemBuilder: (context, index) {
                Stock stock = data[index];
                return Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: StockIndexInfo(stock: stock));
              }),
        ),
      ),
    );
  }
}
