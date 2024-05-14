import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/presentation/bloc/createEvent/create_event_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/producerFlow/add_coordinates.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_date_picker.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_time_picker.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/image/image_bloc.dart';
import '../../config/globals.dart';
import '../../config/helper.dart';
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
  static final startDateController = TextEditingController();
  static final startTimeController = TextEditingController();
  static final endDateController = TextEditingController();
  static final endTimeController = TextEditingController();
  static final locationDetails = TextEditingController();
  static DateTime endDate = DateTime.now();
  static DateTime endTime = DateTime.now();
  static DateTime startDate = DateTime.now();
  static DateTime startTime = DateTime.now();
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
              WedfluencerHeadings.generalHeading(heading: 'Start Date'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                  controller: startDateController,
                  showIcon: false,
                  hint: 'Start Date',
                  enabled: false,
                  onTap: () async {
                    final pickedDate = await showDialog(
                        context: context,
                        builder: (context) => const CustomDatePickerDialog(
                              title: "Add your event start date",
                            ));
                    if (pickedDate != null) {
                      startDate = pickedDate;
                      startDateController.text =
                          DateFormat('dd/MM/yyyy').format(pickedDate!);
                    }
                  }),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Start Time'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                  controller: startTimeController,
                  showIcon: false,
                  hint: 'Start Time',
                  enabled: false,
                  onTap: () async {
                    final pickedTime = await showDialog(
                        context: context,
                        builder: (context) => const CustomTimePickerDialog(
                              title: "Add your event start time",
                            ));
                    if (pickedTime != null) {
                      startTime = pickedTime;
                      startTimeController.text =
                          Time.fromTimeOfDay(pickedTime, 0).format(context);
                    }
                  }),
              WedfluencerDividers.transparentDivider(),
              WedfluencerHeadings.generalHeading(heading: 'End Date'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                  controller: endDateController,
                  showIcon: false,
                  hint: 'End Date',
                  enabled: false,
                  onTap: () async {
                    final pickedDate = await showDialog(
                        context: context,
                        builder: (context) => const CustomDatePickerDialog(
                              title: "Add your event end date",
                            ));
                    if (pickedDate != null) {
                      endDate = pickedDate;
                      endDateController.text =
                          DateFormat('hh:mm a dd/MM/yyyy').format(pickedDate!);
                    }
                  }),
              WedfluencerHeadings.generalHeading(heading: 'End Time'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                  controller: endTimeController,
                  showIcon: false,
                  hint: 'End Time',
                  enabled: false,
                  onTap: () async {
                    final pickedTime = await showDialog(
                        context: context,
                        builder: (context) => const CustomTimePickerDialog(
                              title: "Add your event end time",
                            ));
                    if (pickedTime != null) {
                      endTime = pickedTime;
                      endTimeController.text =
                          Time.fromTimeOfDay(pickedTime, 0).format(context);
                    }
                  }),
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
              WedfluencerMultiDropdown.vendorServiceDropdown(
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
                  placeId: placeId.trim(),
                  description: description.text.trim(),
                  categoryIds: categories,
                  tags: [tags.text.trim()],
                  referralCode: referralCode.text.trim(),
                  locationDetails: locationDetails.text.trim(),
                  location: searchController.text.trim(),
                  endDate: DateTime(endDate.year, endDate.month, endDate.day,
                      endDate.hour, endDate.minute),
                  startDate: DateTime(startDate.year, startDate.month,
                      startDate.day, startTime.hour, startTime.minute),
                  imageIds: [state.image.id!]));
            } else if (state is EventCreated) {
              Navigator.of(context).push(
                WedfluencerHelper.createRoute(
                  page: AddCoordinates(event: state.event),
                ),
              );
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
