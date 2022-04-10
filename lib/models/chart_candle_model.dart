import 'package:candlesticks/candlesticks.dart';

class CustomChartCandle extends Candle {
  CustomChartCandle(
      {required timestamp,
      required high,
      required low,
      required open,
      required close,
      required volume})
      : super(
            date: timestamp,
            high: high,
            low: low,
            open: open,
            close: close,
            volume: volume);
}
