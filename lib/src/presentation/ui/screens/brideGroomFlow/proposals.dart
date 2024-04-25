import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';
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
                  Data counts = state.proposalVideoApiResponse.data!;
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
                                count: state
                                    .proposalVideoApiResponse.data!.total!),
                            displayProposalCount(
                                title: 'Approved\nRequests',
                                count: counts.approved!),
                            displayProposalCount(
                                title: 'Denied\nRequests',
                                count: counts.declined!),
                            displayProposalCount(
                                title: 'Reject\nRequests',
                                count: counts.removed!),
                            displayProposalCount(
                                title: 'Disabled\nRequests',
                                count: counts.disabled!),
                          ],
                        ),
                      ),
                      WedfluencerDividers.transparentDivider(),
                      SizedBox(
                        height: ScreenConfig.screenSizeHeight * 0.72,
                        child: ListView.builder(
                            itemCount: state.proposalVideoApiResponse.data!
                                    .proposalVideos!.length +
                                1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index ==
                                  state.proposalVideoApiResponse.data!
                                      .proposalVideos!.length) {
                                return SizedBox(
                                    height:
                                        ScreenConfig.screenSizeHeight * 0.1);
                              }
                              final video = state.proposalVideoApiResponse.data!
                                  .proposalVideos![index];
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
                  // return SizedBox(
                  //   height: ScreenConfig.screenSizeHeight * 0.8,
                  //   child: FutureBuilder(
                  //     future: initVideoPlayer(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.done) {
                  //         return ListView.builder(
                  //             itemCount: state.proposals.length,
                  //             itemBuilder: (context, index) {
                  //               print(state.proposals.length);
                  //               final video = state.proposals[index];
                  //               return Text(video.title!);
                  //             });
                  //         // return GridView.builder(
                  //         //   gridDelegate:
                  //         //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //         //     crossAxisSpacing: 12,
                  //         //     mainAxisSpacing: 12,
                  //         //     crossAxisCount: 2,
                  //         //   ),
                  //         //   shrinkWrap: true,
                  //         //   itemCount: 11,
                  //         //   itemBuilder: (context, index) {
                  //         //     return WedfluencerCards.proposalCard(
                  //         //       videoPlayerController: controller,
                  //         //       onTap: () {
                  //         //         // Navigator.of(context).push(
                  //         //         //   WedfluencerHelper.createRoute(
                  //         //         //     page: const EventDetailsScreen(),
                  //         //         //   ),
                  //         //         // );
                  //         //       },
                  //         //     );
                  //         //   },
                  //         // );
                  //       }
                  //       return Center(
                  //         child: SizedBox(
                  //           height: ScreenConfig.screenSizeHeight * 0.1,
                  //           child: const CircularProgressIndicator(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // );
                } else if (state is UserProposalsLoading) {
                  return const CircularProgressIndicator();
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
