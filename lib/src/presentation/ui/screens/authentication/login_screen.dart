import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_dto.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_event.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_state.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/register_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/decorations.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../config/helper.dart';
import '../../templates/dialogs.dart';
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
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadUserCredentials();
  }

  void loadUserCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = (pref.getBool('rememberMe') ?? false);
      if (rememberMe) {
        email.text = (pref.getString('email') ?? '');
        password.text = (pref.getString('password') ?? '');
      }
    });
  }

  void saveUserCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (rememberMe) {
      await pref.setString('email', email.text);
      await pref.setString('password', password.text);
    }
    await pref.setBool('rememberMe', rememberMe);
  }

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
      showBackButton: false,
      heading: 'Login to your Account',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            iconData: Icons.email_rounded,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
            errorMessage: 'Enter a valid email',
          ),
        ),
        SizedBox(height: 0.02.sh),
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
        SizedBox(height: 0.02.sh),
        SizedBox(
          width: ScreenConfig.screenSizeWidth,
          child: Center(
            child: CheckboxListTile(
              value: rememberMe,
              onChanged: (val) {
                setState(() {
                  rememberMe = val!;
                });
              },
              title: Text(
                "Remember Me",
                style: ScreenConfig.theme.textTheme.labelSmall,
              ),
            ),
          ),
        ),
        SizedBox(height: 0.02.sh),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.signInLoading) {
              return const CircularProgressIndicator();
            } else {
              return WedfluencerButtons.fullWidthButton(
                text: 'Sign in',
                textColor: Colors.white,
                func: () {
                  saveUserCredentials();
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationSignInEvent(
                      dto: UserDTO(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      ),
                    ),
                  );
                },
                buttonColor: ScreenConfig.theme.colorScheme.primary,
                hasIcon: false,
              );
            }
          },
        ),
        SizedBox(height: 0.04.sh),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                    showCancelButton: false,
                    title: 'Coming Soon',
                    bodyText:
                        'This feature is in development process and will come soon',
                    filledButtonText: 'Okay',
                    onConfirmation: () {},
                  );
                });
          },
          child: Text(
            'Forgot the password?',
            style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: ScreenConfig.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(height: 0.04.sh),
        WedfluencerDividers.dividerWithText(
          text: 'or continue with',
          width: 0.24.sw,
          dividerColor: Colors.black.withOpacity(0.2),
          textColor: Colors.black,
        ),
        SizedBox(height: 0.04.sh),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            displaySocialIcon(
              icon: 'Group 73.png',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        showCancelButton: false,
                        title: 'Coming Soon',
                        bodyText:
                            'This feature is in development process and will come soon',
                        filledButtonText: 'Okay',
                        onConfirmation: () {},
                      );
                    });
              },
            ),
            displaySocialIcon(
              icon: 'Group 74.png',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        showCancelButton: false,
                        title: 'Coming Soon',
                        bodyText:
                            'This feature is in development process and will come soon',
                        filledButtonText: 'Okay',
                        onConfirmation: () {},
                      );
                    });
              },
            ),
            displaySocialIcon(
              icon: 'Group 75.png',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        showCancelButton: false,
                        title: 'Coming Soon',
                        bodyText:
                            'This feature is in development process and will come soon',
                        filledButtonText: 'Okay',
                        onConfirmation: () {},
                      );
                    });
              },
            ),
          ],
        ),
        SizedBox(height: 0.02.sh),
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
        SizedBox(height: 0.04.sh),
      ],
    );
  }
}
