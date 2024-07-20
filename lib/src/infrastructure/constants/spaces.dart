import '../screen_size_config/screen_size_config.dart';

class Spaces {
  Spaces._();
  //Vertical Spacing
  static final defaultSpacingVertical = ScreenConfig.screenSizeHeight * 0.02;
  static final defaultSpacingHorizontal = ScreenConfig.screenSizeWidth * 0.02;

  static final fieldSpacingVertical = ScreenConfig.screenSizeHeight * 0.015;
  static final labelSpacingVertical = ScreenConfig.screenSizeHeight * 0.01;
  static final smallestSpacingVertical = ScreenConfig.screenSizeHeight * 0.004;
  //Horizontal Spacing
  static final betweenTextSpacing = ScreenConfig.screenSizeWidth * 0.01;
}
