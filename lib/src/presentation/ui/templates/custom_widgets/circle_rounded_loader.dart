import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

import '../../../../infrastructure/constants/colors.dart';
import '../../../../infrastructure/constants/spaces.dart';
import 'height_spacer.dart';

class CircleRoundedLoader extends StatelessWidget {
  const CircleRoundedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeightSpacer(
          space: Spaces.defaultSpacingVertical * 2,
        ),
        CircularProgressIndicator(
          color: ScreenConfig.theme.primaryColor,
        ),
        const HeightSpacer(),
        Text(
          'Loading ...',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: ThemeColors().themeDarkColor,
          ),
        ),
        const HeightSpacer(),
      ],
    );
  }
}

class CircleRoundedLoaderWithoutText extends StatelessWidget {
  const CircleRoundedLoaderWithoutText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const HeightSpacer(),
        SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            color: ScreenConfig.theme.primaryColor,
          ),
        ),
        const HeightSpacer(),
      ],
    );
  }
}
