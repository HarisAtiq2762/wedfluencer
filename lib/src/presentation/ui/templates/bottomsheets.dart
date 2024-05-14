import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wedfluencer/src/presentation/ui/config/dateFormatter.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../models/proposal_video.dart';
import 'buttons.dart';
import 'dividers.dart';
import 'headings.dart';

class WedfluencerBottomSheets {
  static Future<dynamic> generalBottomSheet({
    required BuildContext context,
    required Widget child,
    required double height,
    String? heading,
  }) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                ),
              ),
              height: height,
              width: ScreenConfig.screenSizeWidth,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffCDCFD0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  SizedBox(height: heading != null ? 15 : 0),
                  heading != null
                      ? Text(
                          heading,
                          style: ScreenConfig.theme.textTheme.headlineSmall
                              ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
                  child
                ],
              ));
        });
  }

  static void displayBottomSheet(
          {required BuildContext context,
          required ProposalVideo proposalVideo}) =>
      WedfluencerBottomSheets.generalBottomSheet(
        height: ScreenConfig.screenSizeHeight * 0.76,
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  proposalVideo.file.thumbnail,
                  fit: BoxFit.fill,
                  width: ScreenConfig.screenSizeWidth,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                proposalVideo.title,
                style: ScreenConfig.theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              WedfluencerDividers.transparentDivider(),
              Text(
                'Topics',
                style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              proposalVideo.topics.isEmpty
                  ? Text(
                      'No Topics',
                      style: ScreenConfig.theme.textTheme.bodySmall,
                    )
                  : Row(
                      children: [
                        for (int i = 0; i < proposalVideo.topics.length; i++)
                          Text(
                            '${proposalVideo.topics[i]}, ',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
              WedfluencerDividers.transparentDivider(),
              Text(
                'Keywords',
                style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              proposalVideo.keywords.isEmpty
                  ? Text(
                      'No Keywords',
                      style: ScreenConfig.theme.textTheme.bodySmall,
                    )
                  : Row(
                      children: [
                        for (int i = 0; i < proposalVideo.keywords.length; i++)
                          Text(
                            '${proposalVideo.keywords[i]}, ',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
              WedfluencerDividers.transparentDivider(),
              Text(
                'Labels',
                style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              proposalVideo.labels.isEmpty
                  ? Text(
                      'No Labels',
                      style: ScreenConfig.theme.textTheme.bodySmall,
                    )
                  : Row(
                      children: [
                        for (int i = 0; i < proposalVideo.labels.length; i++)
                          Text(
                            '${proposalVideo.labels[i]}, ',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                          ),
                      ],
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
                    ' ${eventDate.format(proposalVideo.createdAt)}',
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
      );

  static void displayFilterBottomSheet(
          {required BuildContext context,
          required TextEditingController googlePlacesTextFiledController}) =>
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
}
