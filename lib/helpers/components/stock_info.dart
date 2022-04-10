import 'package:flutter/material.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/components/market_change_text.dart';
import 'package:flutter_stonks/helpers/components/pre_post_text.dart';
import 'package:flutter_stonks/helpers/responsive.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:flutter_stonks/routes.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class StockInfo extends StatelessWidget {
  const StockInfo({Key? key, required this.stock, this.disableOnClick = false})
      : super(key: key);
  final Stock stock;
  final bool disableOnClick;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 5,
      child: InkWell(
        onTap: disableOnClick
            ? null
            : () {
                context.read<StockDataState>().setClickedStock(stock);
                Routemaster.of(context)
                    .push(AppRoutes.chart + "/" + stock.symbol);
              },
        child: SizedBox(
          //height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    stock.isFavourite = !stock.isFavourite;
                    context
                        .read<StockDataState>()
                        .handleSetFavourite(stock, context);
                  },
                  icon: stock.isFavourite
                      ? Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const Icon(Icons.star_border),
                ),
                Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Responsive.isMobile(context) ? 180 : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(stock.symbol,
                                  style: Theme.of(context).textTheme.headline6),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                  fit: BoxFit.fitWidth, child: Text(stock.name))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(stock.marketPrice.toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6), //style:const TextStyle(fontWeight:FontWeight.bold,fontSize: )),
                              const SizedBox(
                                height: 5,
                              ),
                              MarketChangeText(
                                  marketChange: stock.marketChange),

                              if (stock.marketState != MarketState.regular) ...[
                                const SizedBox(
                                  height: 5,
                                ),
                                PrePostText(stock: stock),
                              ]
                            ],
                          ),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
