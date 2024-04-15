import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/templates/bottomsheets.dart';
import 'package:wedfluencer/src/presentation/ui/templates/cards.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../templates/buttons.dart';
import '../../templates/headings.dart';
import '../../templates/khairyat_appbar.dart';

class VendorLeadsScreen extends StatelessWidget {
  const VendorLeadsScreen({super.key});

  static final googlePlacesTextFiledController = TextEditingController();

  void displayBottomSheet({required BuildContext context}) =>
      WedfluencerBottomSheets.generalBottomSheet(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logos/logo.png',
                  fit: BoxFit.cover,
                  width: ScreenConfig.screenSizeWidth * 0.38,
                ),
              ),
              Text(
                'Title',
                style: ScreenConfig.theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Tags',
                style: ScreenConfig.theme.textTheme.bodySmall,
              ),
              WedfluencerDividers.transparentDivider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_outlined,
                    size: 18,
                    color: ScreenConfig.theme.primaryColor,
                  ),
                  Text(
                    ' 29 - 03 - 2024',
                    style: ScreenConfig.theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: ScreenConfig.theme.primaryColor,
                  ),
                  Text(
                    ' Mulhouse, France',
                    style: ScreenConfig.theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.people_alt_outlined,
                    size: 18,
                    color: ScreenConfig.theme.primaryColor,
                  ),
                  Text(
                    ' 2',
                    style: ScreenConfig.theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerButtons.smallButton(
                text: 'Chat',
                textColor: Colors.white,
                func: () {},
                buttonColor: ScreenConfig.theme.colorScheme.primary,
                hasIcon: false,
                iconData: Icons.open_in_new,
              ),
            ],
          ),
        ),
        height: ScreenConfig.screenSizeHeight * 0.5,
      );
  void displayFilterBottomSheet({required BuildContext context}) =>
      WedfluencerBottomSheets.generalBottomSheet(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerTextFields.iconTextField(
                controller: TextEditingController(),
                showIcon: false,
                hint: 'Search in words, Topics',
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: googlePlacesTextFiledController,
                isGooglePlaces: true,
                showIcon: false,
                // hint: 'Wedding Location',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Date Range'),
              SfDateRangePicker(
                selectionShape: DateRangePickerSelectionShape.circle,
                enablePastDates: true,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerButtons.smallButton(
                text: 'Apply',
                textColor: Colors.white,
                func: () {
                  Navigator.pop(context);
                },
                buttonColor: ScreenConfig.theme.colorScheme.primary,
                hasIcon: false,
                iconData: Icons.open_in_new,
              ),
            ],
          ),
        ),
        height: ScreenConfig.screenSizeHeight * 0.8,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Events',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              controller: TextEditingController(),
              iconData: Icons.search,
              hint: 'Search the content',
              showSuffix: true,
              suffixIcon: Icons.filter_list_sharp,
              color: Colors.white,
              onTapSuffix: () {
                displayFilterBottomSheet(context: context);
              },
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerHeadings.generalHeading(
              heading: 'Leads Videos'.toUpperCase(),
              textAlign: TextAlign.center,
            ),
            WedfluencerDividers.transparentDivider(),
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.7,
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: 11,
                itemBuilder: (context, index) {
                  return WedfluencerCards.leadCard(
                    onTap: () => displayBottomSheet(context: context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
