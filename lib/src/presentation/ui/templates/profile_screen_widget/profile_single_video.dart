import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_widgets/circle_rounded_loader.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class ProfileSingleVideo extends StatelessWidget {
  const ProfileSingleVideo({
    super.key,
    required this.url,
    required this.thumbnailUrl,
    this.showThumbnail = false,
  });
  final String url, thumbnailUrl;
  final bool showThumbnail;
  @override
  Widget build(BuildContext context) {
    if (showThumbnail) {
      return CachedNetworkImage(
        imageUrl: thumbnailUrl,
        fit: BoxFit.cover,
        width: ScreenConfig.screenSizeWidth,
        progressIndicatorBuilder: (context, _, __) {
          return const CircleRoundedLoaderWithoutText();
        },
        errorWidget: (context, _, __) {
          return Image.asset(
            'assets/logos/logo.png',
            fit: BoxFit.contain,
            width: ScreenConfig.screenSizeWidth,
            height: ScreenConfig.screenSizeHeight * 0.6,
          );
        },
      );
    } else {
      return _RenderVideo(
        url: url,
      );
    }
  }
}

class _RenderVideo extends StatefulWidget {
  const _RenderVideo({
    required this.url,
  });
  final String url;

  @override
  State<_RenderVideo> createState() => __RenderVideoState();
}

class __RenderVideoState extends State<_RenderVideo> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url.toString(),
      ),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            autoPlay: false,
            looping: true,
          );
          _isLoading = false;
        });
      });

    _controller.addListener(() {
      if (_controller.value.isBuffering) {
        setState(() {
          _isLoading = true;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    _chewieController?.dispose();
    super.dispose();
  }

  Widget _getRenderWidget() {
    if (_isLoading) {
      return const CircleRoundedLoaderWithoutText();
    } else {
      if (_chewieController != null &&
          _chewieController!.videoPlayerController.value.isInitialized) {
        return Chewie(
          controller: _chewieController!,
        );
      } else {
        return const CircleRoundedLoaderWithoutText();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenSizeHeight * 0.6,
      width: ScreenConfig.screenSizeWidth,
      child: Center(
        child: _getRenderWidget(),
      ),
    );

    // AspectRatio(
    //   // height: ScreenConfig.screenSizeHeight * 0.6,
    //   // width: ScreenConfig.screenSizeWidth * 0.5,
    //   aspectRatio: _controller.value.aspectRatio,
    //   child: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           VideoPlayer(_controller),
    //           _ControlsOverlay(controller: _controller),
    //           VideoProgressIndicator(
    //             _controller,
    //             allowScrubbing: true,
    //             colors: VideoProgressColors(
    //               playedColor: ScreenConfig.theme.primaryColor,
    //               backgroundColor: Colors.white,
    //               bufferedColor: Colors.grey,
    //             ),
    //           )
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
