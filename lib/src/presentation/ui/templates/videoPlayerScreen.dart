import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import 'dividers.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final String title;
  final String description;
  final List tags;
  const VideoPlayerScreen(
      {super.key,
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

  @override
  Widget build(BuildContext context) {
    Widget displaySideButton({required IconData icon, required String text}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            Text(
              text,
              style: ScreenConfig.theme.textTheme.labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
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
              displaySideButton(icon: Icons.favorite, text: '250.5K'),
              WedfluencerDividers.transparentDivider(),
              displaySideButton(icon: Icons.comment, text: '100K'),
              WedfluencerDividers.transparentDivider(),
              displaySideButton(icon: Icons.bookmark, text: '89K'),
              WedfluencerDividers.transparentDivider(),
              displaySideButton(icon: Icons.share, text: '132K'),
            ],
          ),
        );
    return SizedBox(
      height: ScreenConfig.screenSizeHeight,
      width: ScreenConfig.screenSizeWidth,
      child: Stack(
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
                  child: SizedBox(
                    height: ScreenConfig.screenSizeHeight,
                    child: VideoPlayer(_controller),
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
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Butterfly Video'),
    //   ),
    //   // Use a FutureBuilder to display a loading spinner while waiting for the
    //   // VideoPlayerController to finish initializing.
    //   body: FutureBuilder(
    //     future: _initializeVideoPlayerFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // If the VideoPlayerController has finished initialization, use
    //         // the data it provides to limit the aspect ratio of the video.
    //         return AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           // Use the VideoPlayer widget to display the video.
    //           child: VideoPlayer(_controller),
    //         );
    //       } else {
    //         // If the VideoPlayerController is still initializing, show a
    //         // loading spinner.
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    //   // floatingActionButton: FloatingActionButton(
    //   //   onPressed: () {
    //   //     // Wrap the play or pause in a call to `setState`. This ensures the
    //   //     // correct icon is shown.
    //   //     setState(() {
    //   //       // If the video is playing, pause it.
    //   //       if (_controller.value.isPlaying) {
    //   //         _controller.pause();
    //   //       } else {
    //   //         // If the video is paused, play it.
    //   //         _controller.play();
    //   //       }
    //   //     });
    //   //   },
    //   //   // Display the correct icon depending on the state of the player.
    //   //   child: Icon(
    //   //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //   //   ),
    //   // ),
    // );
  }
}
