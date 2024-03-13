import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/profile_details_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/wedding_details.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';

class OtpScreen extends StatelessWidget {
  final bool isPhoneVerification;
  const OtpScreen({super.key, required this.isPhoneVerification});
  static const routeName = '/otp-screen';

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading:
          isPhoneVerification ? 'Number Verification' : 'E-mail Verification',
      children: [
        OtpTextField(
          numberOfFields: 6,
          showFieldAsBox: false,
          borderWidth: 4.0,
          focusedBorderColor: ScreenConfig.theme.primaryColor,
          borderColor: ScreenConfig.theme.primaryColor,
          onCodeChanged: (String code) {},
          onSubmit: (String verificationCode) {},
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        WedfluencerButtons.fullWidthButton(
          text: 'Submit',
          textColor: Colors.white,
          func: () {
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: isPhoneVerification
                    ? const WeddingDetailsScreen()
                    : const ProfileDetailsScreen(),
              ),
            );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDivider(),
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
