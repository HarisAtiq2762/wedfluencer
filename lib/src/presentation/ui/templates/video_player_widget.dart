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

  @override
  void initState() {
    super.initState();
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
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            onTap: () {
              if (_controller.value.isPlaying) {
                setState(() {
                  _controller.pause();
                });
              } else {
                setState(() {
                  _controller.play();
                });
              }
            },
            child: _controller.value.isPlaying
                ? VideoPlayer(_controller)
                // AspectRatio(
                //         aspectRatio: _controller.value.aspectRatio,
                //         child: VideoPlayer(_controller),
                //       )
                : Center(
                    child: Image.network(
                      widget.video.file.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Image.asset(
                          'assets/logos/logo.png',
                          fit: BoxFit.contain,
                          width: ScreenConfig.screenSizeWidth,
                          height: ScreenConfig.screenSizeHeight * 0.6,
                        );
                      },
                    ),
                  ),
          );
        } else {
          return Center(
            child: Image.network(
              widget.video.file.thumbnail,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}
