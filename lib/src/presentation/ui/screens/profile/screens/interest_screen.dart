import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/multi_selection_widget.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
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
        title: 'Select Interest',
      ),
      body: Column(
        children: [
          MultiSelectionWidget<String>(values: const [
            'item 1',
            'item 2',
            'item 3',
            'item 4',
            'item 5',
            'item 6',
          ], selectedValues: const [
            'item 1',
            'item 2',
            'item 3',
          ], onChange: (item, remove) {}),
          WedfluencerButtons.fullWidthButton(
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
              text: 'Save Changes',
              textColor: Colors.white,
              widthMultiplier: 1,
              func: () {}),
        ],
      ),
    );
  }
}
