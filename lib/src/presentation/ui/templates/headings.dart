import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerHeadings {
  static Widget generalHeading(
          {required String heading,
          Color color = Colors.black,
          TextAlign? textAlign,
          FontWeight fontWeight = FontWeight.bold}) =>
      Text(
        heading,
        style:
            ScreenConfig.theme.textTheme.headlineSmall?.copyWith(color: color, fontWeight: fontWeight),
        textAlign: textAlign,

      );
  static Widget planHeading({required String heading}) => Text(
        heading,
        style: ScreenConfig.theme.textTheme.bodyLarge
            ?.copyWith(color: Colors.white),
      );
}
