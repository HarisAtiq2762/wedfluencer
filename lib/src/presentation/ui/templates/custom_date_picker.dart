import 'package:flutter/material.dart';
import 'package:wedfluencer/src/app.dart';

class CustomDatePickerDialog extends StatelessWidget {
  final String title;
  final DateTime? firstdate, lastDate;
  const CustomDatePickerDialog({
    super.key,
    required this.title,
    this.firstdate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          dialogBackgroundColor: Colors.white,
          colorScheme: const ColorScheme.light(primary: themeColor)),
      child: Dialog(
        child: SingleChildScrollView(
          child: DatePickerDialog(
            helpText: title,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            firstDate: firstdate ?? DateTime.now(),
            lastDate: lastDate ?? DateTime(2050),
          ),
        ),
      ),
    );
  }
}
