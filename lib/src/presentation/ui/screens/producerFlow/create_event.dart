import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/headings.dart';
import '../../templates/textfields.dart';
import '../../templates/upload_image.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final rePassword = TextEditingController();
  static final phoneNumber = TextEditingController();
  static final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Create Event',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Wedding Show Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Referral Code',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: email,
            showIcon: false,
            hint: 'Tags',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Start Time'),
              SizedBox(
                width: ScreenConfig.screenSizeWidth,
                height: ScreenConfig.screenSizeHeight * 0.3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  showDayOfWeek: true,
                  dateOrder: DatePickerDateOrder.ymd,
                  onDateTimeChanged: (val) {},
                ),
              ),
              WedfluencerHeadings.generalHeading(heading: 'End Time'),
              SizedBox(
                width: ScreenConfig.screenSizeWidth,
                height: ScreenConfig.screenSizeHeight * 0.3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  showDayOfWeek: true,
                  dateOrder: DatePickerDateOrder.ymd,
                  onDateTimeChanged: (val) {},
                ),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(
                  heading: 'Wedding Show Location'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: searchController,
                isGooglePlaces: true,
                showIcon: false,
                showSuffix: false,
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.multilineTextField(
                controller: TextEditingController(),
                hint: 'Location Details',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Other Details'),
              WedfluencerDividers.transparentDivider(),
              MultiSelectDropDown<int>(
                onOptionSelected: (List<ValueItem> selectedOptions) {},
                options: const <ValueItem<int>>[
                  ValueItem(label: 'Seller new', value: 1),
                  ValueItem(label: 'Cake', value: 2),
                  ValueItem(label: 'Wedding Planners', value: 3),
                  ValueItem(label: 'Bridal Salons', value: 4),
                  ValueItem(label: 'Catering', value: 5),
                  ValueItem(label: 'Wedding Photographers', value: 6),
                  ValueItem(label: 'Reception Venues', value: 7),
                ],
                selectionType: SelectionType.multi,
                hint: 'Select Vendor Category',
                chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                dropdownHeight: ScreenConfig.screenSizeHeight * 0.24,
                optionTextStyle: ScreenConfig.theme.textTheme.bodySmall,
                selectedOptionIcon: const Icon(Icons.check_circle),
                inputDecoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.multilineTextField(
                controller: TextEditingController(),
                hint: 'Description',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Cover Image'),
              WedfluencerDividers.transparentDivider(),
              const UploadImageWidget(),
              WedfluencerDividers.transparentDividerForHeadings(),
            ],
          ),
        ),
        WedfluencerButtons.fullWidthButton(
          text: 'Next',
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
