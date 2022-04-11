import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({Key? key, required this.title, required this.children})
      : super(key: key);
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        color: Theme.of(context).bottomAppBarColor,
        type: MaterialType.card,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: Padding(
                      padding: const EdgeInsets.all(8), child: Text(title)),
                  width: double.infinity),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}
