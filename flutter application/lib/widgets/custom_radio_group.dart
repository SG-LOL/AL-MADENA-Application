import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';

class RadioGroup extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;

  RadioGroup({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.v),
        for (String option in widget.options)
          RadioListTile<String>(
            activeColor: Color.fromARGB(255, 101, 170, 238),
            title: Text(option),
            value: option,
            groupValue: widget.selectedOption,
            onChanged: (value) {
              setState(() {
                widget.onChanged(value ?? "");
              });
            },
          ),
      ],
    );
  }
}
