import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SimpleDropdownButton extends HookWidget {
  const SimpleDropdownButton(
      {Key? key,
      required this.data,
      required this.onChange,
      required this.initialValue})
      : super(key: key);
  final List<String> data;
  final Function(String?) onChange;
  final String initialValue;
  @override
  Widget build(BuildContext context) {
    var dropdownValue = useState<String?>(initialValue);

    return DropdownButton<String>(
      value: dropdownValue.value,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      //style: const TextStyle(color: C),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String? newValue) {
        dropdownValue.value = newValue;
        onChange(newValue);
      },
      items: data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
