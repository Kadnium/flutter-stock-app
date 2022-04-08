import 'package:flutter/material.dart';
import 'package:flutter_stonks/helpers/components/horizontal_stock_container.dart';
import 'package:flutter_stonks/helpers/components/stock_container.dart';
import 'package:flutter_stonks/routes.dart';
import 'package:flutter_stonks/screens/home/components/favourites_container.dart';
import 'package:flutter_stonks/screens/home/components/most_changed_container.dart';
import 'package:flutter_stonks/screens/home/components/stock_index_container.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
        const SizedBox(height: 5,),
        StockIndexContainer(),
        const SizedBox(height: 25,),
        MostChangedContainer(),
        const SizedBox(height: 50,),
        FavouritesContainer(),
        const SizedBox(height: 25),
        
        
        ]),
    );
  }
}
