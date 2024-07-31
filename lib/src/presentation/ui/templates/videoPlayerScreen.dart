import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../bloc/comment/comment_service.dart';
import '../../bloc/reaction/reaction_service.dart';
import 'dividers.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String postId;
  final String url;
  final String title;
  final String description;
  final List tags;
  const VideoPlayerScreen(
      {super.key,
      required this.postId,
      required this.url,
      required this.title,
      required this.tags,
      required this.description});

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
    required String text,
    VoidCallback? onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            Text(
              text,
              style: ScreenConfig.theme.textTheme.labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      );

  Widget displayProfileImage() => Badge(
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
  Widget displaySideBar() => Container(
        width: ScreenConfig.screenSizeWidth * 0.94,
        height: ScreenConfig.screenSizeHeight * 0.8,
        padding: EdgeInsets.only(left: ScreenConfig.screenSizeWidth * 0.82),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            displayProfileImage(),
            WedfluencerDividers.transparentDividerForHeadings(),
            displaySideButton(
              icon: Icons.favorite,
              text: '250.5K',
              onTap: () {
                ReactionService().updateReaction(
                  postId: widget.postId,
                  reaction: "Like",
                );
              },
            ),
            WedfluencerDividers.transparentDivider(),
            displaySideButton(
              icon: Icons.comment,
              text: '0',
              onTap: () {
                CommentService().showCommentBottomSheet(
                  context,
                  postId: widget.postId,
                );
              },
            ),
            WedfluencerDividers.transparentDivider(),
            displaySideButton(icon: Icons.bookmark, text: '89K'),
            WedfluencerDividers.transparentDivider(),
            displaySideButton(icon: Icons.share, text: '132K'),
          ],
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
              return InkWell(
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
