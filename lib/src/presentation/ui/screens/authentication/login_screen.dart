import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/user/user_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/userHome/user_home_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/userProposals/user_proposals_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/register_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/home.dart';
import 'package:wedfluencer/src/presentation/ui/screens/producerFlow/producer_home.dart';
import 'package:wedfluencer/src/presentation/ui/screens/vendorFlow/vendor_home.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/checkbox.dart';
import 'package:wedfluencer/src/presentation/ui/templates/decorations.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../config/helper.dart';
import '../../templates/dividers.dart';
import '../../templates/snackbar.dart';

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
    Widget displaySocialIcon(
            {required String icon, required void Function()? onTap}) =>
        InkWell(
          onTap: onTap,
          child: Image.asset(
            'assets/logos/$icon',
            width: 87,
            height: 60,
          ),
        );

    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Login to your Account',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            iconData: Icons.email_rounded,
            hint: 'Email',
          ),
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
        BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoggedIn) {
              BlocProvider.of<UserHomeBloc>(context).add(GetExploreVideos());
              BlocProvider.of<UserProposalsBloc>(context)
                  .add(GetUserProposals(accessToken: state.user.accessToken!));
              Navigator.of(context).push(
                WedfluencerHelper.createRoute(page: const HomeScreen()),
              );
            } else if (state is GotError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(WedfluencerSnackBar.showSnackBar(state.error));
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const CircularProgressIndicator();
            }
            return WedfluencerButtons.fullWidthButton(
              text: 'Sign in',
              textColor: Colors.white,
              func: () {
                BlocProvider.of<UserBloc>(context)
                    .add(LoginUser(email: email.text, password: password.text));
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            );
          },
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
            displaySocialIcon(
              icon: 'Group 73.png',
              onTap: () {
                Navigator.of(context).push(
                  WedfluencerHelper.createRoute(
                    page: const ProducerHomeScreen(),
                  ),
                );
              },
            ),
            displaySocialIcon(
              icon: 'Group 74.png',
              onTap: () {
                Navigator.of(context).push(
                  WedfluencerHelper.createRoute(page: const VendorHomeScreen()),
                );
              },
            ),
            displaySocialIcon(
              icon: 'Group 75.png',
              onTap: () {
                Navigator.of(context).push(
                  WedfluencerHelper.createRoute(page: const HomeScreen()),
                );
              },
            ),
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
