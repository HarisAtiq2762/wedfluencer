import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/config/helper.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/post_view/screens/view_post.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_image_widget.dart';

import '../../../../infrastructure/dependency_injection.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class ProfilePhotoListingWidget extends StatelessWidget {
  const ProfilePhotoListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostDeleted) {
          DI.i<PostBloc>().add(GetPosts(isImage: true, posts: []));
        }
      },
      builder: (context, state) {
        if (state is GotPosts) {
          if (state.posts.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset('assets/animations/empty.json'),
                Text('No images found',
                    style: ScreenConfig.theme.textTheme.bodySmall),
              ],
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return InkWell(
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
                  child: CustomImageWidget(
                    height: 100,
                    width: 100,
                    imageUrl: post.url,
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
