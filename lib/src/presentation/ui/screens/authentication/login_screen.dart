import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/register_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/checkbox.dart';
import 'package:wedfluencer/src/presentation/ui/templates/decorations.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../config/helper.dart';
import '../../templates/dividers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    Widget displaySocialIcon({required String icon}) => Image.asset(
          'assets/logos/$icon',
          width: 87,
          height: 60,
        );

    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Login to your Account',
      children: [
        WedfluencerTextFields.iconTextField(
          controller: email,
          iconData: Icons.email_rounded,
          hint: 'Email',
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
        WedfluencerTextFields.formPasswordTextField(
          controller: password,
          hidePassword: isObscure,
          icon: GestureDetector(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            child: Icon(
              isObscure
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          iconImage: 'Vector (1).png',
          hint: 'Password',
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
        const WedfluencerCheckboxWidget(text: 'Remember Me'),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
        WedfluencerButtons.fullWidthButton(
          text: 'Sign in',
          textColor: Colors.white,
          func: () {
            // Navigator.of(context).push(
            //   WedfluencerHelper.createRoute(
            //     page: isDoctor
            //         ? const DoctorHomeScreen()
            //         : const PatientHomeScreen(),
            //   ),
            // );
            // // Navigator.pushNamed(context, HomeScreen.routeName);
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
        Text(
          'Forgot the password?',
          style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: ScreenConfig.theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
        WedfluencerDividers.dividerWithText(
          text: 'or continue with',
          width: ScreenConfig.screenSizeWidth * 0.24,
          dividerColor: Colors.black.withOpacity(0.2),
          textColor: Colors.black,
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            displaySocialIcon(icon: 'Group 73.png'),
            displaySocialIcon(icon: 'Group 74.png'),
            displaySocialIcon(icon: 'Group 75.png'),
          ],
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
              children: [
                TextSpan(
                  text: ' Sign Up ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ScreenConfig.theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
      ],
    );
  }
}
