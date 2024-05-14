import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/models/proposal_video.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class VideoPlayerWidget extends StatefulWidget {
  final ProposalVideo video;
  const VideoPlayerWidget({super.key, required this.video});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String tag = '';

  @override
  void initState() {
    super.initState();

    for (var element in widget.video.keywords) {
      tag += '#$element';
    }
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.file.url),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);

    // _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
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
