import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/models/proposal_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/khairyat_appbar.dart';

class ProposalDetailsScreen extends StatefulWidget {
  final ProposalVideo video;

  const ProposalDetailsScreen({super.key, required this.video});

  @override
  State<ProposalDetailsScreen> createState() => _ProposalDetailsScreenState();
}

class _ProposalDetailsScreenState extends State<ProposalDetailsScreen> {
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
      Uri.parse(widget.video.file.url.toString()),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);

    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Proposal Details',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.3,
              child: FutureBuilder(
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
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WedfluencerDividers.transparentDivider(),
                  WedfluencerHeadings.generalHeading(
                      heading: widget.video.title),
                  WedfluencerDividers.transparentDividerForHeadings(),
                  WedfluencerHeadings.generalHeading(heading: 'Category'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: ScreenConfig.screenSizeHeight * 0.06,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Wrap(runSpacing: 8, spacing: 8, children: [
                            ActionChip(
                              label: Text(widget.video.category[index].title),
                              labelStyle: ScreenConfig.theme.textTheme.bodySmall
                                  ?.copyWith(color: Colors.white),
                              backgroundColor: ScreenConfig.theme.primaryColor,
                              onPressed: () =>
                                  print("Perform some action here"),
                            ),
                          ]),
                        );
                      },
                      itemCount: widget.video.category.length,
                    ),
                  ),
                  WedfluencerDividers.transparentDividerForHeadings(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WedfluencerHeadings.generalHeading(heading: 'Status'),
                          Text(
                            widget.video.status.toUpperCase(),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WedfluencerHeadings.generalHeading(heading: 'Price'),
                          Text(
                            "\$${widget.video.price}",
                            style: ScreenConfig.theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  WedfluencerDividers.transparentDividerForHeadings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
