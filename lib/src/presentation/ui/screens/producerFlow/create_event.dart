import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/presentation/bloc/createEvent/create_event_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/image/image_bloc.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/headings.dart';
import '../../templates/multiDropdown.dart';
import '../../templates/textfields.dart';
import '../../templates/upload_image.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  static final email = TextEditingController();
  static final title = TextEditingController();
  static final password = TextEditingController();
  static final rePassword = TextEditingController();
  static final phoneNumber = TextEditingController();
  static final searchController = TextEditingController();
  static final description = TextEditingController();
  static final tags = TextEditingController();
  static final referralCode = TextEditingController();
  static final locationDetails = TextEditingController();
  static DateTime endDate = DateTime.now();
  static DateTime startDate = DateTime.now();
  static List<ValueItem> categories = [];

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Create Event',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: title,
            showIcon: false,
            hint: 'Wedding Show Name',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: referralCode,
            showIcon: false,
            hint: 'Referral Code',
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: tags,
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
                  onDateTimeChanged: (val) {
                    endDate = val;
                  },
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
                controller: locationDetails,
                hint: 'Location Details',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Other Details'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerMultiDropdown.vendorCategoryDropdown(
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  categories = selectedOptions;
                },
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.multilineTextField(
                controller: description,
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
        BlocConsumer<CreateEventBloc, CreateEventState>(
          listener: (context, state) {
            if (state is EventImagesUploaded) {
              BlocProvider.of<CreateEventBloc>(context).add(CreateEvent(
                  title: title.text.trim(),
                  placeId: searchController.text.trim(),
                  description: description.text.trim(),
                  categoryIds: categories,
                  tags: [tags.text.trim()],
                  referralCode: referralCode.text.trim(),
                  locationDetails: locationDetails.text.trim(),
                  location: searchController.text.trim(),
                  endDate: endDate,
                  startDate: startDate,
                  imageIds: [state.image.id!]));
            } else if (state is EventCreated) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is CreateEventLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return WedfluencerButtons.fullWidthButton(
              text: 'Next',
              textColor: Colors.white,
              func: () {
                final imageState = BlocProvider.of<ImageBloc>(context).state;
                if (imageState is GotImages) {
                  BlocProvider.of<CreateEventBloc>(context)
                      .add(UploadEventImages(image: imageState.file!));
                }
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            );
          },
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
