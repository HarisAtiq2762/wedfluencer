import 'package:flutter/material.dart';
import 'package:wedfluencer/src/app.dart';

class CustomTimePickerDialog extends StatelessWidget {
  final String title;
  const CustomTimePickerDialog({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          dialogBackgroundColor: Colors.white,
          colorScheme: const ColorScheme.light(primary: themeColor)),
      child: Dialog(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: TimePickerDialog(
            helpText: title,
            initialEntryMode: TimePickerEntryMode.dialOnly,
            initialTime: TimeOfDay.now(),
          ),
        ),
      ),
    );
  }
}
