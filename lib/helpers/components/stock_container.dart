import 'package:flutter/material.dart';
import 'package:flutter_stonks/helpers/components/common_container.dart';
import 'package:flutter_stonks/helpers/components/stock_info.dart';
import 'package:flutter_stonks/models/stock_model.dart';

class StockContainer extends StatelessWidget {
  const StockContainer({Key? key, required this.title, required this.data})
      : super(key: key);
  final String title;
  final List<Stock> data;
  @override
  Widget build(BuildContext context) {
    return CommonContainer(title: title, children: [
      ListView.builder(
        //primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: StockInfo(stock: data[index]),
          );
        },
      ),
    ]);
  }
}
