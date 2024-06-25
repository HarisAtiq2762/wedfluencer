import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';

class ProfileVideoListingWidget extends StatelessWidget {
  const ProfileVideoListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        print(state);
        if (state is GotPosts) {
          return GridView.builder(
            padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.6,
                child: WebViewWidget(
                    controller: WebViewController()
                      ..loadRequest(Uri.parse(post.url))),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
