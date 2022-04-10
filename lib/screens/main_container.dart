import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/helpers/responsive.dart';
import 'package:flutter_stonks/helpers/shared_preferences_helper.dart';
import 'package:flutter_stonks/screens/app_header.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class MainContainerTabPage extends StatelessWidget {
  const MainContainerTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);

    bool isDesktop = Responsive.isDesktop(context);
    Color primaryCol = Theme.of(context).colorScheme.primary;
    Color? iconCol = Theme.of(context).iconTheme.color;
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: const AppHeader(),
        //key:context.read<AppState>().mainScaffoldKey,
        //endDrawer: AppDrawer(),
        bottomNavigationBar: Container(
          color: Theme.of(context).bottomAppBarColor,
          child: TabBar(
            indicatorColor: primaryCol,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.home,
                color: tabPage.controller.index == 0 ? primaryCol : iconCol,
              )),
              Tab(
                  icon: Icon(
                Icons.search,
                color: tabPage.controller.index == 1 ? primaryCol : iconCol,
              )),
              Tab(
                  icon: Icon(
                Icons.settings,
                color: tabPage.controller.index == 2 ? primaryCol : iconCol,
              )),
            ],
            controller: tabPage.controller,
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
          ],
        ));
  }
}

class MainContainerSinglePage extends StatelessWidget {
  const MainContainerSinglePage({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //key:context.read<AppState>().mainScaffoldKey,
        appBar: const AppHeader(),
        body: child);
  }
}
