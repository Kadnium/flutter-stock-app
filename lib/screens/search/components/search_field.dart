import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/controllers/search_state.dart';
import 'package:flutter_stonks/helpers/debouncer.dart';
import 'package:provider/provider.dart';

class SearchField extends HookWidget {
  SearchField({Key? key,required this.onChange, required this.label}) : super(key: key);
  final Function(String) onChange;
  final String label;
  final Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    var textEditingController = useTextEditingController();
    
    useEffect(() {
      
      return ()=> debouncer.cancel();
    },[]);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: TextField(
          controller: textEditingController,
          onChanged:(val)=>debouncer.debounce(() {
            onChange(val);
          }),
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
        ));
  }
}
