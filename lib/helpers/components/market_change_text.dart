import 'package:flutter/material.dart';

class MarketChangeText extends StatelessWidget {
  const MarketChangeText({Key? key, required this.marketChange})
      : super(key: key);
  final double marketChange;
  @override
  Widget build(BuildContext context) {
    return Text(
      marketChange.toStringAsFixed(2) + "%",
      style: TextStyle(color: marketChange >= 0 ? Colors.green : Colors.red),
    );
  }
}
