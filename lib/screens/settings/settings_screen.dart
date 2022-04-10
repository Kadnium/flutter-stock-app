import 'package:flutter/material.dart';
import 'package:flutter_stonks/controllers/app_state.dart';
import 'package:flutter_stonks/helpers/components/common_container.dart';
import 'package:flutter_stonks/screens/settings/components/setting_switch.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState aState = context.watch<AppState>();
    return ListView(children: [
      const SizedBox(
        height: 15,
      ),
      CommonContainer(title: "Asetukset", children: [
        SettingSwitch(
          checked: aState.darkTheme,
          onChanged: (val) {
            aState.setDarkTheme(val);
          },
          titleText: "Tumma teema",
        ),
        SettingSwitch(
          checked: aState.lineChart,
          onChanged: (val) {
            aState.setLineChart(val);
          },
          titleText: "Käytä viivakaaviota kaaviosivulla",
        ),
      ])
    ]);
  }
}
