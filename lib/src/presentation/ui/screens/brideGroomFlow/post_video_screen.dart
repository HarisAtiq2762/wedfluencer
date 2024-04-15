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

class PostVideoScreen extends StatefulWidget {
  const PostVideoScreen({super.key});

  static List selectedOptions = [];

  @override
  State<PostVideoScreen> createState() => _PostVideoScreenState();
}

class _PostVideoScreenState extends State<PostVideoScreen> {
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
                  ValueItem(label: 'Seller new', value: 1),
                  ValueItem(label: 'Cake', value: 2),
                  ValueItem(label: 'Wedding Planners', value: 3),
                  ValueItem(label: 'Bridal Salons', value: 4),
                  ValueItem(label: 'Catering', value: 5),
                  ValueItem(label: 'Wedding Photographers', value: 6),
                  ValueItem(label: 'Reception Venues', value: 7),
                ],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                dropdownHeight: ScreenConfig.screenSizeHeight * 0.24,
                optionTextStyle: ScreenConfig.theme.textTheme.bodySmall,
                selectedOptionIcon: const Icon(Icons.check_circle),
                inputDecoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
