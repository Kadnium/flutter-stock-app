import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stonks/screens/chart/chart_screen.dart';
import 'package:flutter_stonks/screens/home/home_screen.dart';
import 'package:flutter_stonks/screens/main_container.dart';
import 'package:flutter_stonks/screens/search/search_screen.dart';
import 'package:flutter_stonks/screens/settings/settings_screen.dart';

import 'package:routemaster/routemaster.dart';

class AppRoutes {
  static const root = "/";
  static const home = "/home";
  static const search = "/search";
  static const settings = "/settings";
  static const chartParams = "/chart/:symbol";
  static const chart = "/chart";
}

class AppPages {
  static Page privateRoute(Page route, BuildContext context) {
    // if (!context.read<AppState>().isLoggedIn) {
    //   return const Redirect(UserRoutes.login);
    // }

    return route;
  }

  static RouteMap appRoutes(BuildContext context) {
    return RouteMap(routes: {
      AppRoutes.root: (routeData) {
        return privateRoute(
            TabPage(
                pageBuilder: (child) => CustomMaterialPage(child: child),
                paths: const [
                  AppRoutes.home,
                  AppRoutes.search,
                  AppRoutes.settings,
                ],
                backBehavior: TabBackBehavior.history,
                child: const MainContainerTabPage()),
            context);
      },
      AppRoutes.home: (routeData) {
        return const CustomMaterialPage(child: HomeScreen());
      },
      AppRoutes.search: (routeData) {
        return const CustomMaterialPage(child: SearchScreen());
      },
      AppRoutes.settings: (routeData) {
        return const CustomMaterialPage(child: SettingsScreen());
      },
      AppRoutes.chartParams: (routeData) {
        return CustomMaterialPage(
            child: MainContainerSinglePage(
                child:
                    ChartScreen(symbol: routeData.pathParameters["symbol"])));
      }
    });
  }
}

class CustomMaterialPage extends TransitionBuilderPage<void> {
  const CustomMaterialPage({required Widget child, required})
      : super(child: child);

  @override
  PageTransition buildPushTransition(BuildContext context) {
    TargetPlatform platform = defaultTargetPlatform;
    if (kIsWeb ||
        [TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]
            .contains(platform)) {
      // No push transition on web
      return PageTransition.none;
    }

    // Default Android fade upwards transition on push
    return PageTransition.none;
  }

  @override
  PageTransition buildPopTransition(BuildContext context) {
    TargetPlatform platform = defaultTargetPlatform;
    if (kIsWeb ||
        [TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]
            .contains(platform)) {
      // No pop transition on web
      return PageTransition.none;
    }

    // Cupertino transition on pop
    return PageTransition.cupertino;
  }
}
