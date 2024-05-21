import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/multi_selection_widget.dart';

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70.0, right: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Get better video recommendation',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: MultiSelectionWidget<SelectionModel>(
                  values: List.generate(
                    15,
                    (index) => SelectionModel(
                      id: '$index',
                      label: 'Label $index',
                      imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg',
                    ),
                  ),
                  selectedValues: List.generate(
                    3,
                    (index) => SelectionModel(
                      id: '$index',
                      label: 'Label $index',
                      imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg',
                    ),
                  ),
                  onChange: (item, remove) {},
                  padding: const EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WedfluencerButtons.smallButton(
                  buttonColor: const Color.fromARGB(255, 238, 238, 238)!,
                  hasIcon: false,
                  text: 'Skip',
                  textColor: const Color.fromARGB(255, 32, 32, 32),
                  width: 160,
                  func: () {},
                ),
                WedfluencerButtons.smallButton(
                  buttonColor: ScreenConfig.theme.colorScheme.primary,
                  hasIcon: false,
                  text: 'Submit',
                  textColor: Colors.white,
                  width: 160,
                  func: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
