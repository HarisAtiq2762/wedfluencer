import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/presentation/ui/templates/multiDropdown.dart';

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
              WedfluencerMultiDropdown.vendorServiceDropdown(
                onOptionSelected: (List<ValueItem> selectedOptions) {},
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
