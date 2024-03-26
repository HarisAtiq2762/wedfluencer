import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/vendor_registration_details.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/wedding_planner_registration_screen.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';

class UserCategoryScreen extends StatelessWidget {
  const UserCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Signup As Professionals',
      children: [
        WedfluencerDividers.transparentDividerForHeadings(),
        WedfluencerButtons.fullWidthButton(
          text: 'I am a Vendor',
          textColor: Colors.white,
          func: () {
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const VendorRegistrationDetails(),
              ),
            );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'I am a Wedding Planner',
          textColor: Colors.white,
          func: () {
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const WeddingPlannerRegistrationDetails(),
              ),
            );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'I am a Wedding Producer',
          textColor: Colors.white,
          func: () {
            // Navigator.of(context).push(
            //   WedfluencerHelper.createRoute(
            //     page: const ProfileDetailsScreen(),
            //   ),
            // );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        WedfluencerButtons.fullWidthButton(
          text: 'Back',
          textColor: Colors.black,
          buttonColor: Colors.white,
          borderColor: ScreenConfig.theme.primaryColor,
          func: () {
            Navigator.pop(context);
          },
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
