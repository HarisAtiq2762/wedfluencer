import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wedfluencer/src/presentation/ui/templates/multiDropdown.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/dropdown.dart';
import '../../templates/headings.dart';
import '../../templates/textfields.dart';
import 'otp_screen.dart';

class WeddingPlannerRegistrationDetails extends StatelessWidget {
  const WeddingPlannerRegistrationDetails({super.key});
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final rePassword = TextEditingController();
  static final phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Enter Your Details',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Company Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Trademark Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'First Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Last Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            iconData: Icons.alternate_email,
            showIcon: true,
            hint: 'User Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: true,
            iconData: Icons.web,
            hint: 'Website url',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.phoneNumberField(
          controller: phoneNumber,
          onInputChanged: (PhoneNumber number) {
            print(number.dialCode);
            print(number.isoCode);
            print(number.phoneNumber);
          },
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(
                  heading: 'Select Main Category'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerMultiDropdown.vendorServiceDropdown(),
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Enter Keywords',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Enter Address',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Toll Free',
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(
                  heading: 'Are you offering products ?'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerDropdown.wedfluencerDropdown(
                hint: 'Select option',
                isExpanded: true,
                data: ['Yes', 'No'],
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(
                  heading: 'Are you offering services ?'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerDropdown.wedfluencerDropdown(
                hint: 'Select option',
                isExpanded: true,
                data: ['Yes', 'No'],
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(heading: 'Comments'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.multilineTextField(
                controller: TextEditingController(),
                hint: 'Enter About Yourself',
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        WedfluencerButtons.fullWidthButton(
          text: 'Sign up',
          textColor: Colors.white,
          func: () {
            // BlocProvider.of<UserBloc>(context).add(
            //     GetEmailPassword(email: email.text, password: password.text));
            // Navigator.of(context).push(WedfluencerHelper.createRoute(
            //   page: const OtpScreen(isPhoneVerification: false),
            // ));
            Navigator.of(context).push(WedfluencerHelper.createRoute(
              page: const OtpScreen(isPhoneVerification: true),
            ));
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
