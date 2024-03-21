import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerDropdown extends StatefulWidget {
  final bool? isExpanded;
  final double? width;
  final String hint;
  final List<String> data;
  const WedfluencerDropdown(
      {super.key,
      required this.hint,
      this.isExpanded,
      this.width,
      required this.data});

  @override
  State<WedfluencerDropdown> createState() => _WedfluencerDropdownState();
}

class _WedfluencerDropdownState extends State<WedfluencerDropdown> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton2<dynamic>(
        dropdownStyleData: const DropdownStyleData(
          elevation: 2,
          openInterval: Interval(0.1, 0.8),
        ),
        value: dropdownValue,
        isExpanded: widget.isExpanded ?? false,
        alignment: AlignmentDirectional.centerStart,
        hint: Text(
          widget.hint,
          style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
            color: ScreenConfig.theme.hintColor,
          ),
        ),
        underline: Container(),
        onChanged: (value) {
          setState(() {
            dropdownValue = value;
          });
        },
        items: widget.data.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(
              value.toString(),
              style: ScreenConfig.theme.textTheme.bodySmall,
            ),
          );
        }).toList(),
      ),
    );
  }
}
