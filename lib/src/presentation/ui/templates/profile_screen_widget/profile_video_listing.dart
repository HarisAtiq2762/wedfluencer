import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

import '../../../bloc/post/post_bloc.dart';
import '../../config/helper.dart';
import '../../screens/profile/post_view/screens/view_post.dart';
import 'profile_single_video.dart';

class ProfileVideoListingWidget extends StatelessWidget {
  const ProfileVideoListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is GotPosts) {
          return GridView.builder(
            padding: EdgeInsets.only(
              top: 4,
              left: 4,
              right: 4,
              bottom: ScreenConfig.screenSizeHeight * 0.15,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    WedfluencerHelper.createRoute(
                      page: ViewPostScreen(
                        selectedPost: post,
                        posts: state.posts,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: post.id,
                  child: ProfileSingleVideo(
                    url: post.file.url,
                    thumbnailUrl: post.file.thumbnail,
                    showThumbnail: true,
                  ),
                ),
              );
              // SizedBox(
              //   height: ScreenConfig.screenSizeHeight * 0.6,
              //   child: WebViewWidget(
              //     controller: WebViewController()
              //       ..loadRequest(Uri.parse(post.url)),
              //   ),
              // );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
