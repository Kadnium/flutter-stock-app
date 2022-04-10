import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  const SettingSwitch(
      {Key? key,
      this.padding,
      this.titleText = "",
      required this.checked,
      required this.onChanged})
      : super(key: key);
  final EdgeInsetsGeometry? padding;
  final String titleText;
  final bool checked;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return (ListTile(
      contentPadding: EdgeInsets.only(left: 5),
      leading: Switch(
          activeColor: Theme.of(context).colorScheme.primary,
          // activeTrackColor: Theme.of(context).primaryColor,
          value: checked,
          onChanged: onChanged),
      title: Text(
        titleText,
        style: const TextStyle(fontSize: 16),
      ),
      //hoverColor: Theme.of(context).primaryColor,
    ));
  }
}
