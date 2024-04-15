import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/dropdown.dart';
import '../../templates/headings.dart';
import '../../templates/textfields.dart';

class VendorRegistrationDetails extends StatelessWidget {
  const VendorRegistrationDetails({super.key});
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
        WedfluencerTextFields.phoneNumberField(controller: phoneNumber),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(
                  heading: 'Select Main Category'),
              WedfluencerDividers.transparentDivider(),
              MultiSelectDropDown<int>(
                onOptionSelected: (List<ValueItem> selectedOptions) {},
                options: const <ValueItem<int>>[
                  ValueItem(label: 'Option 1', value: 1),
                  ValueItem(label: 'Option 2', value: 2),
                  ValueItem(label: 'Option 3', value: 3),
                  ValueItem(label: 'Option 4', value: 4),
                  ValueItem(label: 'Option 5', value: 5),
                  ValueItem(label: 'Option 6', value: 6),
                ],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: ScreenConfig.screenSizeHeight * 0.24,
                optionTextStyle: ScreenConfig.theme.textTheme.bodySmall,
                selectedOptionIcon: const Icon(Icons.check_circle),
                inputDecoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(
                  heading: 'Select Secondary Category'),
              WedfluencerDividers.transparentDivider(),
              MultiSelectDropDown<int>(
                onOptionSelected: (List<ValueItem> selectedOptions) {},
                options: const <ValueItem<int>>[
                  ValueItem(label: 'Option 1', value: 1),
                  ValueItem(label: 'Option 2', value: 2),
                  ValueItem(label: 'Option 3', value: 3),
                  ValueItem(label: 'Option 4', value: 4),
                  ValueItem(label: 'Option 5', value: 5),
                  ValueItem(label: 'Option 6', value: 6),
                ],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: ScreenConfig.screenSizeHeight * 0.24,
                optionTextStyle: ScreenConfig.theme.textTheme.bodySmall,
                selectedOptionIcon: const Icon(Icons.check_circle),
                inputDecoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
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
              const WedfluencerDropdown(
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
              const WedfluencerDropdown(
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
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
