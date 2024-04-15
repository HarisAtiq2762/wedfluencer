import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/create_proposal.dart';
import 'package:wedfluencer/src/presentation/ui/templates/cards.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';

import '../../config/helper.dart';
import '../../templates/headings.dart';
import '../../templates/khairyat_appbar.dart';

class ProposalsScreen extends StatelessWidget {
  const ProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Proposals',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WedfluencerDividers.transparentDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WedfluencerHeadings.generalHeading(
                  heading: 'Proposals Videos'.toUpperCase(),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      WedfluencerHelper.createRoute(
                          page: const CreateProposalScreen()),
                    );
                  },
                  child: Icon(Icons.add_circle,
                      color: ScreenConfig.theme.primaryColor),
                ),
              ],
            ),
            WedfluencerDividers.transparentDivider(),
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.8,
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
                  return WedfluencerCards.proposalCard(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   WedfluencerHelper.createRoute(
                      //     page: const EventDetailsScreen(),
                      //   ),
                      // );
                    },
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
