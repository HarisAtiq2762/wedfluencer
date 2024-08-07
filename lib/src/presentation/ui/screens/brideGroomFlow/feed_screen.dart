import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/userHome/user_home_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../../models/post/explore_post.dart';
import '../../templates/videoPlayerScreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  static final search = TextEditingController();

  Widget displaySearchBox() => Container(
        height: ScreenConfig.screenSizeHeight * 0.14,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
        ),
        child: WedfluencerTextFields.iconTextField(
          controller: search,
          hint: '',
          iconData: Icons.search,
          // showSuffix: true,
          // suffixIcon: Icons.qr_code_scanner_outlined,
        ),
      );

  Widget displayBody() => BlocBuilder<UserHomeBloc, UserHomeState>(
        builder: (context, state) {
          if (state is FetchedExplorePostVideos) {
            return Stack(
              children: [
                PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.explorePostList.length,
                    onPageChanged: (index) {},
                    itemBuilder: (context, index) {
                      final ExplorePost currentExplorePost =
                          state.explorePostList[index];
                      return VideoPlayerScreen(
                        postId: currentExplorePost.explorePostId,
                        url: currentExplorePost.file.url,
                        title: currentExplorePost.title,
                        description: currentExplorePost.description,
                        tags: const [''],
                        likeCount: currentExplorePost.numberOfLikes,
                        isLiked: currentExplorePost.liked,
                        shareCount: currentExplorePost.numberOfShares,
                        isShared: currentExplorePost.shared,
                        viewCount: currentExplorePost.numberOfViews,
                        isViewed: currentExplorePost.viewed,
                        commentCount: currentExplorePost.numberOfComments,
                      );
                    }),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ScreenConfig.screenSizeHeight * 0.03),
                    child: displaySearchBox(),
                  ),
                ),

                // ListView.builder(
                //     itemCount: state.videos.length,
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return VideoPlayerScreen(
                //           url: state.videos[index].video.url);
                //     }),
                // InkWell(child: VideoPlayer(controller)),
              ],
            );
          }
          if (state is GotExploreVideos) {
            return Stack(
              children: [
                PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.videos.length,
                    onPageChanged: (index) {},
                    itemBuilder: (context, index) {
                      return VideoPlayerScreen(
                        postId: state.videos[index].id!,
                        url: state.videos[index].video.url,
                        title: state.videos[index].title!,
                        description: state.videos[index].description!,
                        tags: state.videos[index].tags!,
                        likeCount: 0,
                        isLiked: false,
                        shareCount: 0,
                        isShared: false,
                        viewCount: 0,
                        isViewed: false,
                        commentCount: 0,
                      );
                    }),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ScreenConfig.screenSizeHeight * 0.03),
                    child: displaySearchBox(),
                  ),
                ),

                // ListView.builder(
                //     itemCount: state.videos.length,
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return VideoPlayerScreen(
                //           url: state.videos[index].video.url);
                //     }),
                // InkWell(child: VideoPlayer(controller)),
              ],
            );
          }
          return const SizedBox();
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: displayBody(),
    );
  }
}
