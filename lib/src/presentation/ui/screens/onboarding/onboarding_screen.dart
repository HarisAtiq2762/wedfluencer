import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../authentication/login_screen.dart';
import '../authentication/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding-screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: WedfluencerDecorations.scaffoldDecoration(),
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Lottie.asset(
                  'assets/animations/chatWithDoc.json',
                  fit: BoxFit.contain,
                  height: ScreenConfig.screenSizeHeight * 0.4,
                ),
              ],
            ),
            Text(
              'Let’s get started',
              style: ScreenConfig.theme.textTheme.headlineMedium,
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            WedfluencerButtons.fullWidthButton(
              text: 'Continue with Facebook',
              func: () {},
              iconPath: 'assets/logos/fb_icon_325x325 2.png',
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            WedfluencerButtons.fullWidthButton(
              text: 'Continue with Google',
              func: () {},
              iconPath: 'assets/logos/7611770 1.png',
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            WedfluencerButtons.fullWidthButton(
              text: 'Continue with Apple',
              func: () {},
              iconPath: 'assets/logos/Apple-Logo 1.png',
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            WedfluencerDividers.dividerWithText(
              text: 'or',
              dividerColor: Colors.black,
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            WedfluencerButtons.fullWidthButton(
              borderColor: Theme.of(context).primaryColor,
              text: 'Sign in with password',
              textColor: ScreenConfig.theme.colorScheme.primary,
              func: () {
                Navigator.of(context).push(WedfluencerHelper.createRoute(
                  page: const LoginScreen(),
                ));
              },
              hasIcon: false,
              iconPath: 'assets/logos/fb_icon_325x325 2.png',
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(WedfluencerHelper.createRoute(
                  page: const RegistrationScreen(),
                ));
              },
              child: Text.rich(
                TextSpan(
                  text: 'Don’t have an account?',
                  style: ScreenConfig.theme.textTheme.bodySmall,
                  children: const [
                    TextSpan(
                      text: ' Sign Up ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
