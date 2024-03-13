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
  bool isInWeddingBusiness = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isInWeddingBusiness,
      onChanged: (value) {
        setState(() {
          isInWeddingBusiness = value!;
        });
      },
      title: Text(
        widget.text,
        style: ScreenConfig.theme.textTheme.bodySmall,
      ),
    );
  }
}
