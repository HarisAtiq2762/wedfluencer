import 'package:flutter/material.dart';

import '../../../../infrastructure/constants/colors.dart';
import '../../../../infrastructure/constants/font_sizes.dart';
import '../../../../infrastructure/constants/spaces.dart';
import 'height_spacer.dart';

class NoGenericTextFound extends StatelessWidget {
  const NoGenericTextFound({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            HeightSpacer(
              space: Spaces.defaultSpacingVertical * 2,
            ),
            Icon(
              Icons.close_rounded,
              color: ThemeColors().themeDarkColor,
              size: 40,
            ),
            Text(
              'No $text found',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: FontSizes.size14Light(
                color: ThemeColors().themeDarkColor,
              ),
            ),
            const HeightSpacer(),
          ],
        ),
      ],
    );
  }
}
