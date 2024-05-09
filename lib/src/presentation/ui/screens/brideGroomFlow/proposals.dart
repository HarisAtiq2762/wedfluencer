import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/userProposals/user_proposals_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/create_proposal.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/proposal_details.dart';
import 'package:wedfluencer/src/presentation/ui/templates/cards.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';

import '../../config/helper.dart';
import '../../templates/headings.dart';
import '../../templates/khairyat_appbar.dart';

class ProposalsScreen extends StatelessWidget {
  const ProposalsScreen({super.key});

  static VideoPlayerController controller =
      VideoPlayerController.asset('assets/videos/video1.MP4');

  static Future<void> initVideoPlayer() async {
    await controller.initialize();
    // controller.play();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserProposalsBloc>(context)
        .add(GetUserProposals(accessToken: DI.i<AuthRepository>().accessToken));
    Widget displayProposalCount({required String title, required int count}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: ScreenConfig.theme.textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: ScreenConfig.theme.textTheme.bodySmall,
            ),
          ],
        );

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
            BlocBuilder<UserProposalsBloc, UserProposalsState>(
              builder: (context, state) {
                if (state is GotUserProposals) {
                  final countsOfProposals = state.proposalVideoApiResponse;
                  return Column(
                    children: [
                      WedfluencerDividers.transparentDivider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            displayProposalCount(
                                title: 'Total\nRequests',
                                count: state.proposalVideoApiResponse.total),
                            displayProposalCount(
                                title: 'Approved\nRequests',
                                count: countsOfProposals.approved),
                            displayProposalCount(
                                title: 'Denied\nRequests',
                                count: countsOfProposals.declined),
                            displayProposalCount(
                                title: 'Reject\nRequests',
                                count: countsOfProposals.removed),
                            displayProposalCount(
                                title: 'Disabled\nRequests',
                                count: countsOfProposals.disabled),
                          ],
                        ),
                      ),
                      WedfluencerDividers.transparentDivider(),
                      SizedBox(
                        height: ScreenConfig.screenSizeHeight * 0.72,
                        child: ListView.builder(
                            itemCount:
                                countsOfProposals.proposalVideos.length + 1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index ==
                                  countsOfProposals.proposalVideos.length) {
                                return SizedBox(
                                    height:
                                        ScreenConfig.screenSizeHeight * 0.1);
                              }
                              final video =
                                  countsOfProposals.proposalVideos[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: WedfluencerCards.proposalCard(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      WedfluencerHelper.createRoute(
                                        page:
                                            ProposalDetailsScreen(video: video),
                                      ),
                                    );
                                  },
                                  video: video,
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                } else if (state is UserProposalsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
