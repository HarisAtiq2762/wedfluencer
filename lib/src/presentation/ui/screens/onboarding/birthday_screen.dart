import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/onboarding/upload_profile_screen.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});
  static const routeName = '/birthday-screen';

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'What is your birthday?',
      children: [
        SizedBox(
          width: ScreenConfig.screenSizeWidth,
          height: ScreenConfig.screenSizeHeight * 0.3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime(1999),
            onDateTimeChanged: (val) {},
          ),
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
        WedfluencerButtons.fullWidthButton(
          text: 'Next',
          textColor: Colors.white,
          func: () {
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const UploadProfileScreen(),
              ),
            );
            // Navigator.pushNamed(context, UploadProfileScreen.routeName);
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
      ],
    );
  }
}
