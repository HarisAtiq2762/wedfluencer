import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerGeneralDropdown extends StatefulWidget {
  final double? width;
  final List data;
  final String hint;
  String? dropdownValue;
  final bool? isExpanded;
  WedfluencerGeneralDropdown({
    super.key,
    this.width,
    required this.data,
    required this.hint,
    this.dropdownValue,
    this.isExpanded,
  });

  @override
  State<WedfluencerGeneralDropdown> createState() =>
      _WedfluencerGeneralDropdownState();
}

class _WedfluencerGeneralDropdownState
    extends State<WedfluencerGeneralDropdown> {
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
        value: widget.dropdownValue,
        isExpanded: widget.isExpanded ?? false,
        alignment: AlignmentDirectional.centerStart,
        hint: Text(
          widget.hint,
          style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
            color: ScreenConfig.theme.hintColor,
          ),
        ),
        underline: Container(),
        onChanged: (val) {
          setState(() {
            widget.dropdownValue = val;
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

class WedfluencerDropdown {
  static Widget wedfluencerDropdown({
    double? width,
    void Function(dynamic)? onChanged,
    required List data,
    required String hint,
    String? dropdownValue,
    bool? isExpanded,
  }) =>
      Container(
        width: width,
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
          isExpanded: isExpanded ?? false,
          alignment: AlignmentDirectional.centerStart,
          hint: Text(
            hint,
            style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
              color: ScreenConfig.theme.hintColor,
            ),
          ),
          underline: Container(),
          onChanged: onChanged,
          items: data.map<DropdownMenuItem<dynamic>>((dynamic value) {
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
