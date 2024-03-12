import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerDropdowns {
  static Widget dropdown({
    required dynamic value,
    required void Function(dynamic)? onChanged,
    required List data,
    String hint = 'Choose another',
    double? width,
    bool isExpanded = false,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButton2<dynamic>(
          dropdownStyleData: const DropdownStyleData(
            elevation: 2,
            openInterval: Interval(0.1, 0.8),
          ),
          value: value,
          isExpanded: isExpanded,
          alignment: AlignmentDirectional.centerStart,
          hint: Text(hint),
          underline: Container(),
          onChanged: onChanged,
          items: data.map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
