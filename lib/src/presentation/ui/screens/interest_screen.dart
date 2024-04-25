import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import 'interest/multi_selection_widget.dart';

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
                child: MultiSelectionWidget<SelectionModel>(values:  [
                  ...List.generate(15,(index)=>SelectionModel(
                      id: '$index', label: 'Label $index', imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg'))
                 ], selectedValues:  [
                  ...List.generate(3,(index)=>SelectionModel(
                      id: '$index', label: 'Label $index', imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg'))
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
