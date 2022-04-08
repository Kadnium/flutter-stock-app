import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_stonks/controllers/app_state.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/controllers/stock_data_state.dart';
import 'package:flutter_stonks/routes.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
    // Add support for 120hz displays
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => StockDataState()),
    ChangeNotifierProvider(create: (context) => AppState()),
    ChangeNotifierProvider(create: (context) => SearchState()),
  ], child: const StonksApp()));
}

class StonksApp extends StatelessWidget {
  const StonksApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: CustomScrollBehavior(),
      title: 'Partion retkipaikat',
      debugShowCheckedModeBanner: false,
      //supportedLocales: kSupportedLocales.keys.map((locale) => Locale(locale)),
      //locale: context.select((AppState a) => a.appLocale),
      /*localizationsDelegates: const [
        AppLocalizationDelegate(),
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        SmnMaterialLocalizations.delegate
      ],*/
      darkTheme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme()
              .copyWith(backgroundColor: const Color(0xFF1a202c)),
          //bottomAppBarTheme: const BottomAppBarTheme().copyWith(),
          iconTheme: IconThemeData().copyWith(color: Colors.white),
          // tabBarTheme: const TabBarTheme()
          //     .copyWith(labelColor:Colors.white ),
          bottomAppBarColor: const Color(0xFF1a202c),
          primaryColor: const Color(0xFF253764),
          scaffoldBackgroundColor: const Color(0xFF101518),
          colorScheme: const ColorScheme.dark(
              primary: Colors.green, secondary: Color(0xFF253764)),
          primaryColorLight: const Color(0xFF28aae1)),
      /*  themeMode: context.select((AppState a) {
        if (a.darkTheme) {
          return ThemeMode.dark;
        }
        return ThemeMode.light;
      }), */
      themeMode: ThemeMode.dark,
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: Colors.white,
          ),
          // tabBarTheme: const TabBarTheme()
          // .copyWith(labelColor:Colors.black ),
          iconTheme: const IconThemeData().copyWith(color: Colors.black),
          primaryColor: const Color(0xFF253764),
          colorScheme: const ColorScheme.light(
            primary: Colors.green,
            secondary: Color(0xFF28aae1),
          ),
          primaryColorLight: const Color(0xFF28aae1)),

      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        return AppPages.appRoutes(context);
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
