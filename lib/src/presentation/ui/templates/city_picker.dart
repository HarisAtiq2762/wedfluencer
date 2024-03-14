import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class WedfluencerCityPicker extends StatefulWidget {
  const WedfluencerCityPicker({super.key});

  @override
  State<WedfluencerCityPicker> createState() => _WedfluencerCityPickerState();
}

class _WedfluencerCityPickerState extends State<WedfluencerCityPicker> {
  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      countrySearchPlaceholder: "Wedding Country",
      stateSearchPlaceholder: "Wedding State",
      citySearchPlaceholder: "Wedding City",
      dropdownDecoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledDropdownDecoration: BoxDecoration(
        color: const Color(0xFFE1E1E1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      onCountryChanged: (value) {
        print(value);
        setState(() {
          // countryValue = value;
        });
      },
      onStateChanged: (value) {
        setState(() {
          // stateValue = value;
        });
      },
      onCityChanged: (value) {
        setState(() {
          // cityValue = value;
        });
      },
    );
  }
}
