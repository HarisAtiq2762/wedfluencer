import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/user/user_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/login_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/otp_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/snackbar.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../config/validator.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/textfields.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const routeName = '/registration-screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();
  bool isObscure = true;
  bool isGettingMarried = true;
  bool reIsObscure = true;

  // final emailFocus = FocusNode();

  void signUp() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      if (validateStructureEmail(email.text) &&
          validateStructurePassword(password.text)) {
        if (rePassword.text == password.text) {
          BlocProvider.of<UserBloc>(context).add(
            GetEmailPassword(
              email: email.text,
              password: password.text,
              confirmPassword: rePassword.text,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            WedfluencerSnackBar.showSnackBar(
              color: ScreenConfig.theme.colorScheme.error,
              'passwords not matched',
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        WedfluencerSnackBar.showSnackBar(
          color: ScreenConfig.theme.colorScheme.error,
          'email or password can not be empty',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Create your Account',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            validateStructure: validateStructureEmail(email.text),
            controller: email,
            iconData: Icons.email_rounded,
            hint: 'Email',
            errorMessage: 'Enter a valid email',
            onChanged: (val) {
              setState(() {
                validateStructureEmail(email.text);
              });
            },
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.formPasswordTextField(
          controller: password,
          hidePassword: isObscure,
          validateStructure: validateStructurePassword(password.text),
          onChanged: (val) {
            setState(() {
              validateStructureEmail(password.text);
            });
          },
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
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.formPasswordTextField(
          controller: rePassword,
          hidePassword: reIsObscure,
          icon: GestureDetector(
            onTap: () {
              setState(() {
                reIsObscure = !reIsObscure;
              });
            },
            child: Icon(
              reIsObscure
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          iconImage: 'Vector (1).png',
          hint: 'Confirm Password',
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            if (state is Loading) {
              return const CircularProgressIndicator();
            }
            return WedfluencerButtons.fullWidthButton(
              text: 'Sign up',
              textColor: Colors.white,
              func: () => signUp(),
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            );
          },
          listener: (context, state) {
            if (state is GotEmailPassword) {
              Navigator.of(context).push(WedfluencerHelper.createRoute(
                page: const OtpScreen(isPhoneVerification: false),
              ));
            } else if (state is GotError) {
              ScaffoldMessenger.of(context).showSnackBar(
                WedfluencerSnackBar.showSnackBar(
                  color: ScreenConfig.theme.colorScheme.error,
                  state.error,
                ),
              );
            }
          },
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(WedfluencerHelper.createRoute(
              page: const LoginScreen(),
            ));
          },
          child: Text.rich(
            TextSpan(
              text: 'Already have an account?',
              style: ScreenConfig.theme.textTheme.bodySmall,
              children: [
                TextSpan(
                  text: ' Sign In ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ScreenConfig.theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
