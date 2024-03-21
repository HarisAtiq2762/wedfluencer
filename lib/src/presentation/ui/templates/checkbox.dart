import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerCheckboxWidget extends StatefulWidget {
  final String text;
  const WedfluencerCheckboxWidget({super.key, required this.text});

  @override
  State<WedfluencerCheckboxWidget> createState() =>
      _WedfluencerCheckboxWidgetState();
}

class _WedfluencerCheckboxWidgetState extends State<WedfluencerCheckboxWidget> {
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenConfig.screenSizeWidth,
      child: Center(
        child: CheckboxListTile(
          value: checkboxValue,
          onChanged: (val) {
            setState(() {
              checkboxValue = val!;
            });
          },
          title: Text(
            widget.text,
            style: ScreenConfig.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
