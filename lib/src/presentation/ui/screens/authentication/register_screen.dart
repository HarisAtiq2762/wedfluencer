import 'package:flutter/material.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
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
  final name = TextEditingController();
  final phone = TextEditingController();
  final rePassword = TextEditingController();

  bool isObscure = true;
  bool reIsObscure = true;

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Create your Account',
      children: [
        WedfluencerTextFields.iconTextField(
          controller: name,
          iconImage: 'person.png',
          hint: 'Full Name',
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.iconTextField(
          controller: email,
          iconImage: 'Vector.png',
          hint: 'Email',
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.iconTextField(
          controller: phone,
          iconImage: 'phone.png',
          hint: 'Phone Number',
        ),
        WedfluencerDividers.transparentDivider(),
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
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'I am a doctor',
                style: ScreenConfig.theme.textTheme.labelSmall,
              ),
              const SizedBox(width: 10),
              // Switch(
              //   value: isDoctor,
              //   trackOutlineColor:
              //       MaterialStatePropertyAll(ScreenConfig.theme.primaryColor),
              //   inactiveThumbColor: ScreenConfig.theme.hintColor,
              //   onChanged: (val) {
              //     setState(() {
              //       isDoctor = val;
              //     });
              //   },
              // ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'Sign up',
          textColor: Colors.white,
          func: () {
            // Navigator.of(context).push(WedfluencerHelper.createRoute(
            //   page: const GenderScreen(),
            // ));
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(WedfluencerHelper.createRoute(
            //   page: const LoginScreen(),
            // ));
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
