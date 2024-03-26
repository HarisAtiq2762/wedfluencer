import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerDividers {
  static Widget dividerWithText(
          {required String text,
          Color? textColor,
          double? width,
          Color? dividerColor}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: width ?? ScreenConfig.screenSizeWidth * 0.4,
            color: dividerColor ?? Colors.white,
            height: 1,
          ),
          Text(
            text,
            style: ScreenConfig.theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Container(
            width: width ?? ScreenConfig.screenSizeWidth * 0.4,
            color: dividerColor ?? Colors.white,
            height: 1,
          )
        ],
      );

  static Widget transparentDivider() =>
      SizedBox(height: ScreenConfig.screenSizeHeight * 0.02);

  static Widget transparentDividerForHeadings() =>
      SizedBox(height: ScreenConfig.screenSizeHeight * 0.04);

  static Widget spacingForScreenEnd() =>
      SizedBox(height: ScreenConfig.screenSizeHeight * 0.14);
}
