import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/userHome/user_home_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../templates/videoPlayerScreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  static final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget displaySearchBox() => Container(
          height: ScreenConfig.screenSizeHeight * 0.14,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: WedfluencerTextFields.iconTextField(
            controller: search,
            hint: 'Find Friends',
            iconData: Icons.search,
            showSuffix: true,
            suffixIcon: Icons.qr_code_scanner_outlined,
          ),
        );

    Widget displayBody() => BlocBuilder<UserHomeBloc, UserHomeState>(
          builder: (context, state) {
            if (state is GotExploreVideos) {
              return Stack(
                children: [
                  PageView.builder(
                      itemCount: state.videos.length,
                      onPageChanged: (index) {},
                      itemBuilder: (context, index) {
                        return VideoPlayerScreen(
                          url: state.videos[index].video.url,
                          title: state.videos[index].title!,
                          description: state.videos[index].description!,
                          tags: state.videos[index].tags!,
                        );
                      }),
                  displaySearchBox(),

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
    return SafeArea(
      child: Scaffold(
        body: displayBody(),
      ),
    );
  }
}
