import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/upload_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';

import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/categoryRadioButton.dart';
import '../../templates/dividers.dart';
import '../../templates/textfields.dart';

class PostProposalScreen extends StatefulWidget {
  const PostProposalScreen({super.key});

  static List selectedOptions = [];

  @override
  State<PostProposalScreen> createState() => _PostProposalScreenState();
}

class _PostProposalScreenState extends State<PostProposalScreen> {
  final title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WedfluencerAppbar.generalAppbar(
        title: 'Upload Video',
        context: context,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerDividers.transparentDivider(),
              WedfluencerHeadings.generalHeading(heading: 'Choose Category'),
              const WedfluencerCategoryRadioButton(),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Enter Title'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: title,
                showIcon: false,
                hint: 'Title',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
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
                        onTap: () {
                          PostProposalScreen.selectedOptions
                              .add('Option ${index + 7}');
                        },
                        child: Text('Option ${index + 7}',
                            style: ScreenConfig.theme.textTheme.bodySmall),
                      );
                    }),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Custom #hashtags'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: title,
                showIcon: false,
                hint: 'HashTags',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              Center(
                child: WedfluencerButtons.fullWidthButton(
                  text: 'Next',
                  textColor: Colors.white,
                  buttonColor: ScreenConfig.theme.colorScheme.primary,
                  hasIcon: false,
                  func: () {
                    Navigator.of(context).push(
                      WedfluencerHelper.createRoute(
                        page: const UploadVideoScreen(),
                      ),
                    );
                  },
                ),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerDividers.transparentDividerForHeadings(),
            ],
          ),
        ),
      ),
    );
  }
}
