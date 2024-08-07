import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerCategoryRadioButton extends StatefulWidget {
  const WedfluencerCategoryRadioButton({super.key});

  @override
  State<WedfluencerCategoryRadioButton> createState() =>
      _WedfluencerCategoryRadioButtonState();
}

class _WedfluencerCategoryRadioButtonState
    extends State<WedfluencerCategoryRadioButton> {
  String selectedOption = 'Free';
  final price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Radio<String>(
                    toggleable: true,
                    value: 'Free',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                Text('Free', style: ScreenConfig.theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(width: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Radio<String>(
                    toggleable: true,
                    value: 'Paid',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                Text('Paid', style: ScreenConfig.theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
        selectedOption == 'Paid'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WedfluencerDividers.transparentDivider(),
                  WedfluencerHeadings.generalHeading(heading: 'Price'),
                  WedfluencerDividers.transparentDivider(),
                  WedfluencerTextFields.iconTextField(
                    controller: price,
                    width: ScreenConfig.screenSizeWidth,
                    hint: 'Enter price',
                    showIcon: false,
                    keyboardType: TextInputType.number,
                  )
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
