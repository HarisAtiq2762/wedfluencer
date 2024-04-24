import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/multi_selection_widget.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';

import '../../../../../infrastructure/screen_size_config/screen_size_config.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Edit Interest',
      ),
      body: Column(

        children: [
          WedfluencerDividers.transparentDivider(),
          Expanded(
            child: SingleChildScrollView(
             padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: MultiSelectionWidget<String>(values: const [
                  'item 1',
                  'item 2',
                  'item 3',
                  'item 4',
                  'item 5',
                  'item 6',
                  'item 7',
                  'item 8',
                  'item 9',
                  'item 10',
                  'item 11',
                  'item 12',
                ], selectedValues: const [
                  'item 1',
                  'item 2',
                  'item 3',
                ], onChange: (item, remove) {}),
              ),
            ),
          ),
          
                Padding(
                   padding: const EdgeInsets.all(16),
                  child: WedfluencerButtons.fullWidthButton(
                      buttonColor: ScreenConfig.theme.colorScheme.primary,
                      hasIcon: false,
                      text: 'Save Changes',
                      textColor: Colors.white,
                      widthMultiplier: 1,
                      func: () {}),
                ),
        ],
      ),
    );
  }
}
