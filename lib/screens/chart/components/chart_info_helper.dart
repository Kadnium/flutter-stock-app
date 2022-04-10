import 'package:flutter/material.dart';
import 'package:flutter_stonks/constants.dart';
import 'package:flutter_stonks/helpers/components/market_change_text.dart';
import 'package:flutter_stonks/helpers/components/simple_dropdown_button.dart';

class ChartInfoHelper extends StatelessWidget {
  const ChartInfoHelper(
      {Key? key,
      required this.onTimeFrameChange,
      required this.change,
      required this.onRefreshClick})
      : super(key: key);

  final Function(String? p1) onTimeFrameChange;
  final double change;
  final Function() onRefreshClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SimpleDropdownButton(
                  data: kChartSettingList,
                  onChange: onTimeFrameChange,
                  initialValue: kChartSettingList[0]),
              IconButton(
                  onPressed: onRefreshClick, icon: const Icon(Icons.refresh)),
            ],
          ),
          MarketChangeText(marketChange: change)
        ],
      ),
    );
  }
}
