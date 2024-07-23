import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/config/constants.dart';

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

  static Widget generalDivider() =>
      Divider(color: Colors.black.withOpacity(0.2));

  static Widget transparentDivider() =>
      SizedBox(height: ScreenConfig.screenSizeHeight * 0.02);

  static Widget staticTransparentDivider() => SizedBox(
        height: WedfluencerConstants.containerVerticalPadding,
      );

  static Widget staticTransparentPadding({
    required Widget child,
    double? verticalPadding,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WedfluencerConstants.pageHorizontalPadding,
          vertical:
              verticalPadding ?? WedfluencerConstants.containerVerticalPadding,
        ),
        child: child,
      );

  static Widget lineDivider({
    Color color = Colors.grey,
  }) =>
      Divider(
        color: color,
        height: 0,
        thickness: 0.5,
      );

  static Widget staticTransparentDividerForHeadings() => const SizedBox(
        height: 10,
      );

  static Widget transparentDividerForHeadings() =>
      SizedBox(height: ScreenConfig.screenSizeHeight * 0.04);

  static Widget spacingForScreenEnd() =>
      SizedBox(height: ScreenConfig.screenSizeHeight * 0.14);
}
