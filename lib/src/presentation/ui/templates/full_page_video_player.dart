import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullPageVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool play;
  const FullPageVideoPlayer(
      {super.key, required this.videoUrl, required this.play});

  @override
  State<FullPageVideoPlayer> createState() => _FullPageVideoPlayerState();
}

class _FullPageVideoPlayerState extends State<FullPageVideoPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          widget.play ? controller.play() : null;
          controller.setLooping(true);
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
