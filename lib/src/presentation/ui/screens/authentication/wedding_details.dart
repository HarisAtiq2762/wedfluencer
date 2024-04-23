import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/upload_profile_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dropdown.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/textfields.dart';

class WeddingDetailsScreen extends StatefulWidget {
  const WeddingDetailsScreen({super.key});

  static const routeName = '/wedding-details-screen';

  @override
  State<WeddingDetailsScreen> createState() => _WeddingDetailsScreenState();
}

class _WeddingDetailsScreenState extends State<WeddingDetailsScreen> {
  final searchController = TextEditingController();
  final numberOfGuests = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? weddingType;

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Enter Wedding Details',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerTextFields.iconTextField(
            controller: numberOfGuests,
            iconData: Icons.grading_outlined,
            hint: 'Number of guests',
            keyboardType: TextInputType.number,
            width: ScreenConfig.screenSizeWidth,
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: WedfluencerDropdown.wedfluencerDropdown(
            onChanged: (value) {
              setState(() {
                weddingType = value;
              });
            },
            dropdownValue: weddingType,
            hint: 'Wedding Type',
            isExpanded: true,
            width: ScreenConfig.screenSizeWidth,
            data: [
              'Traditional Weddings',
              'Destination Weddings',
              'Weddings Weekends',
              'Small Weddings',
              'Elopements',
              'Courthouse Weddings',
              'Themed Weddings'
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        SizedBox(
          width: ScreenConfig.screenSizeWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WedfluencerHeadings.generalHeading(
                  heading: 'Wedding Location',
                ),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                  controller: searchController,
                  isGooglePlaces: true,
                  showIcon: false,
                  showSuffix: false,
                )
              ],
            ),
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(heading: 'Wedding Date'),
              SfDateRangePicker(
                selectionShape: DateRangePickerSelectionShape.circle,
                enablePastDates: false,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: (val) {
                  print(val.value);
                  selectedDate = val.value;
                },
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'Submit',
          textColor: Colors.white,
          func: () {
            final userBloc = BlocProvider.of<UserBloc>(context);
            final state = userBloc.state;
            print(state);
            if (state is GotUserProfileDetails) {
              print(state.user.email);
              print(state.user.phoneNumber);
              userBloc.add(GetUserWeddingDetails(
                weddingDate: selectedDate.toString(),
                weddingType: weddingType!,
                guestCount: int.parse(numberOfGuests.text),
                weddingLocation: searchController.text,
                user: state.user,
              ));
              Navigator.of(context).push(WedfluencerHelper.createRoute(
                page: const UploadProfileScreen(),
              ));
            }

            // Navigator.of(context).push(WedfluencerHelper.createRoute(
            //   page: const UploadProfileScreen(),
            // ));
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'Back',
          textColor: Colors.black,
          buttonColor: Colors.white,
          borderColor: ScreenConfig.theme.primaryColor,
          func: () {
            Navigator.pop(context);
          },
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
