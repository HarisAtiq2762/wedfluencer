import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../infrastructure/constants/colors.dart';
import '../../../infrastructure/resources/helper_services/bottom_bar_service.dart';
import '../../../infrastructure/resources/helper_services/count_formatter.dart';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../bloc/comment/comment_service.dart';
import '../../bloc/reaction/reaction_service.dart';
import 'dialogs.dart';
import 'dividers.dart';
import 'feed_side_widgets/feed_button.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String postId;
  final String url;
  final String title;
  final String description;
  final List tags;
  final int likeCount;
  final bool isLiked;
  final int shareCount;
  final bool isShared;
  final int viewCount;
  final bool isViewed;
  final int commentCount;

  const VideoPlayerScreen({
    super.key,
    required this.postId,
    required this.url,
    required this.title,
    required this.tags,
    required this.description,
    required this.likeCount,
    required this.isLiked,
    required this.shareCount,
    required this.isShared,
    required this.viewCount,
    required this.isViewed,
    required this.commentCount,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String tag = '';

  @override
  void initState() {
    super.initState();

    for (var element in widget.tags) {
      tag += '#$element';
    }

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget displaySideButton({
    required IconData icon,
    Color iconColor = Colors.white,
    required String text,
    VoidCallback? onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 30),
            Text(
              text,
              style: ScreenConfig.theme.textTheme.labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      );

  Widget displayProfileImage() => InkWell(
        onTap: () {
          BottomBarService.setProfileNavigation(
            context,
          );
        },
        child: Badge(
          backgroundColor: ScreenConfig.theme.primaryColor,
          label: const Icon(Icons.add, color: Colors.white, size: 16),
          alignment: Alignment.bottomLeft,
          offset: const Offset(11, 16),
          largeSize: 24,
          child: const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/pic1.jpeg'),
            ),
          ),
        ),
      );

  Widget displayTextContent() => SizedBox(
        width: ScreenConfig.screenSizeWidth * 0.7,
        height: ScreenConfig.screenSizeHeight * 0.84,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.title,
                  style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                WedfluencerDividers.transparentDivider(),
                Text(
                  widget.description,
                  style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
                WedfluencerDividers.transparentDivider(),
                Text(
                  tag,
                  style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget displayWatermark() => SizedBox(
        width: ScreenConfig.screenSizeWidth * 0.2,
        height: ScreenConfig.screenSizeHeight * 0.4,
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.0,
            top: ScreenConfig.screenSizeHeight * 0.24,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/logos/logo.png',
              opacity: const AlwaysStoppedAnimation(.5),
            ),
          ),
        ),
      );

  Widget displaySideBar() => Padding(
        padding: EdgeInsets.only(top: ScreenConfig.screenSizeHeight * 0.4),
        child: Container(
          width: ScreenConfig.screenSizeWidth * 0.94,
          // height: ScreenConfig.screenSizeHeight * 0.42,
          height: ScreenConfig.screenSizeHeight * 0.32,
          padding: EdgeInsets.only(left: ScreenConfig.screenSizeWidth * 0.8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: ScreenConfig.theme.primaryColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WedfluencerDividers.transparentDivider(),
                displayProfileImage(),
                WedfluencerDividers.transparentDividerForHeadings(),
                FeedButton(
                  isFormattedCount: true,
                  text: widget.likeCount.toString(),
                  onTap: () {
                    ReactionService().updateReaction(
                      postId: widget.postId,
                      reaction: "Like",
                    );
                  },
                  icon: Icons.favorite,
                  alreadyStatus: widget.isLiked,
                ),
                // displaySideButton(
                //   icon: Icons.favorite,
                //   iconColor: (widget.isLiked)
                //       ? ThemeColors().themeDarkColor
                //       : Colors.white,
                //   text: CountFormatter().formatCount(
                //     widget.likeCount,
                //   ),
                //   onTap: () {
                //     ReactionService().updateReaction(
                //       postId: widget.postId,
                //       reaction: "Like",
                //     );
                //   },
                // ),
                WedfluencerDividers.transparentDivider(),
                displaySideButton(
                  icon: Icons.comment,
                  text: CountFormatter().formatCount(
                    widget.commentCount,
                  ),
                  onTap: () {
                    CommentService().showCommentBottomSheet(
                      context,
                      postId: widget.postId,
                    );
                  },
                ),
                WedfluencerDividers.transparentDivider(),
                // displaySideButton(
                //     icon: Icons.bookmark,
                //     text: '0',
                //     onTap: () {
                //       showDialog(
                //           context: context,
                //           builder: (context) {
                //             return ConfirmationDialog(
                //               showCancelButton: false,
                //               title: 'Coming Soon',
                //               bodyText:
                //                   'This feature is in development process and will come soon',
                //               filledButtonText: 'Okay',
                //               onConfirmation: () {},
                //             );
                //           });
                //     }),
                // WedfluencerDividers.transparentDivider(),
                displaySideButton(
                    icon: Icons.share,
                    iconColor: (widget.isShared)
                        ? ThemeColors().themeDarkColor
                        : Colors.white,
                    text: CountFormatter().formatCount(
                      widget.shareCount,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationDialog(
                              showCancelButton: false,
                              title: 'Coming Soon',
                              bodyText:
                                  'This feature is in development process and will come soon',
                              filledButtonText: 'Okay',
                              onConfirmation: () {},
                            );
                          });
                    }),
                WedfluencerDividers.transparentDivider(),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.size.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: ScreenConfig.theme.primaryColor,
                      backgroundColor: Colors.white,
                      bufferedColor: Colors.grey,
                    ),
                  )
                ],
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        displayTextContent(),
        displaySideBar(),
        displayWatermark(),
      ],
    );
  }
}
