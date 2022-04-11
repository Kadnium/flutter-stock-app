
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stonks/helpers/debouncer.dart';

class CommonTextField extends HookWidget {
  CommonTextField({Key? key,required this.onChange, required this.label, this.useDebouncer = true }) : super(key: key);
  final Function(String) onChange;
  final String label;
  final Debouncer debouncer = Debouncer();
  final bool useDebouncer;
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
          onChanged:useDebouncer?(val)=>debouncer.debounce(() {
            onChange(val);
          }):onChange,
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
        ));
  }
}
