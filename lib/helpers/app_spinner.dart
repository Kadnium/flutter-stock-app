import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({Key? key, this.width = 55, this.height = 55, this.color})
      : super(key: key);

  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: const CircularProgressIndicator(),
        width: width,
        height: height,
      ),
    );
  }
}
