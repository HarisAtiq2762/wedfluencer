import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/upload_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';
import 'package:wedfluencer/src/presentation/ui/templates/multiDropdown.dart';

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
              WedfluencerMultiDropdown.vendorServiceDropdown(
                onOptionSelected: (List<ValueItem> selectedOptions) {},
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
