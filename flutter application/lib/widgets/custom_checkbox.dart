import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';

class CheckboxGroup extends StatefulWidget {
  final String groupTitle;
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;

  CheckboxGroup({
    required this.groupTitle,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  });

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromARGB(255, 101, 170, 238),
                border: Border.all(width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    " " + widget.groupTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.v),
        for (String option in widget.options)
          CheckboxListTile(
            activeColor: Color.fromARGB(255, 101, 170, 238),
            checkColor: Colors.transparent,
            title: Text(option),
            value: widget.selectedOptions.contains(option),
            onChanged: (value) {
              setState(() {
                if (value != null && value) {
                  widget.onChanged([...widget.selectedOptions, option]);
                } else {
                  widget.onChanged([...widget.selectedOptions]..remove(option));
                }
              });
            },
          ),
      ],
    );
  }
}
