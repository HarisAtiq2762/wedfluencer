import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/upload_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';

class CreateProposalScreen extends StatefulWidget {
  const CreateProposalScreen({super.key});

  @override
  State<CreateProposalScreen> createState() => _CreateProposalScreenState();
}

class _CreateProposalScreenState extends State<CreateProposalScreen> {
  String selectedOption = 'No';
  final searchController = TextEditingController();

  Widget displayRichText() => RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text:
                  'Tired of explaining your wedding vision to multiple vendors repeatedly? Use our ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'AI-powered feature! ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  'Share your vision in a video once, and we will match you with relevant vendors. They can then review your video and start a conversation. For the best results, ensure your ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'face is clear, and your voice is audible ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  'in the video. Follow these rules to increase your chances of success without sharing personal information. Get the attention you need from vendors ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'without the hassle! ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget displayRadioButtons() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio<String>(
                      toggleable: true,
                      value: 'No',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  Text('No', style: ScreenConfig.theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(width: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio<String>(
                      toggleable: true,
                      value: 'Yes',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  Text('Yes', style: ScreenConfig.theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ],
      );

  Widget displayWeddingShowForm() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WedfluencerTextFields.iconTextField(
            controller: TextEditingController(),
            showIcon: false,
            hint: 'Referral Code',
          ),
          WedfluencerDividers.transparentDivider(),
          WedfluencerTextFields.iconTextField(
            controller: TextEditingController(),
            showIcon: false,
            hint: 'Wedding Show Name',
          ),
          WedfluencerDividers.transparentDivider(),
          WedfluencerTextFields.iconTextField(
            controller: searchController,
            isGooglePlaces: true,
            showIcon: false,
            showSuffix: false,
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(heading: 'Wedding Show Date'),
              SfDateRangePicker(
                selectionShape: DateRangePickerSelectionShape.circle,
                enablePastDates: false,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              ),
            ],
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Create Proposal',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerDividers.transparentDividerForHeadings(),
              Center(
                child: WedfluencerHeadings.generalHeading(
                  heading:
                      'Start your request for vendor proposal'.toUpperCase(),
                  textAlign: TextAlign.center,
                ),
              ),
              WedfluencerDividers.transparentDivider(),
              displayRichText(),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(
                  heading: 'Are you going to wedding show?'),
              displayRadioButtons(),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: TextEditingController(),
                showIcon: false,
                hint: 'Enter Title',
              ),
              WedfluencerDividers.transparentDivider(),
              selectedOption == 'Yes'
                  ? displayWeddingShowForm()
                  : const SizedBox(),
              selectedOption == 'Yes'
                  ? const SizedBox()
                  : WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(
                  heading: 'Select Vendor Category'),
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
              WedfluencerHeadings.generalHeading(heading: 'Suggestions'),
              WedfluencerDividers.transparentDivider(),
              Container(
                width: ScreenConfig.screenSizeWidth,
                constraints: BoxConstraints(
                  maxHeight: ScreenConfig.screenSizeHeight * 0.2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GridView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 2,
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 18,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Text('Option ${index + 7}',
                            style: ScreenConfig.theme.textTheme.bodySmall),
                      );
                    }),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              Center(
                child: WedfluencerButtons.fullWidthButton(
                  text: 'Next',
                  func: () {
                    Navigator.of(context).push(
                      WedfluencerHelper.createRoute(
                        page: const UploadVideoScreen(),
                      ),
                    );
                  },
                  hasIcon: false,
                  buttonColor: ScreenConfig.theme.primaryColor,
                  textColor: Colors.white,
                ),
              ),
              WedfluencerDividers.spacingForScreenEnd()
            ],
          ),
        ),
      ),
    );
  }
}
