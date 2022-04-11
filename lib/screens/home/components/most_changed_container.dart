import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/api/api_service.dart';
import 'package:flutter_stonks/helpers/app_spinner.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/models/stock_model.dart';
import 'package:provider/provider.dart';

class MostChangedContainer extends HookWidget {
  const MostChangedContainer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    StockDataState state = context.watch<StockDataState>();
    List<Stock> mostChanged = state.mostChangedList;
    useEffect(() {
      if (mostChanged.isEmpty) {
        isLoading.value = true;
        ApiService().stockApi.getDailyMovers().then((stocks) {
          state.setMostChangedData(state.checkIfFavourite(stocks));
        }).catchError((err) {
          print(err);
        }).whenComplete(() => isLoading.value = false);
      }
      return null;
    }, []);

    return Stack(
      alignment: Alignment.center,
      children: [
        StockContainer(title: "Suurimmat muuttujat", data: mostChanged),
        isLoading.value ? const AppSpinner() : const SizedBox()
      ],
    );
  }
}
