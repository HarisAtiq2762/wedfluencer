import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/presentation/bloc/createProposal/create_proposal_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/profile_screen_widget/profile_single_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/snackbar.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/userProposals/user_proposals_bloc.dart';
import '../../config/helper.dart';
import '../../templates/bottomsheets.dart';
import '../../templates/buttons.dart';
import '../../templates/dividers.dart';
import '../../templates/khairyat_appbar.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  late File imageFile;
  double? aspectRatio;

  bool isImagePicked = false;
  late VideoPlayerController _controller;

  void getImage({required ImageSource src}) async {
    imageFile = await WedfluencerHelper.getVideo(src: src);
    setState(() {
      isImagePicked = true;
    });
    _controller = VideoPlayerController.file(imageFile)
      ..initialize().then((value) {
        setState(() {
          aspectRatio = _controller.value.size.aspectRatio;
        });
      });
    _controller.setLooping(false);
    // _controller.play();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // getVideoPosition() {
    //   var duration = Duration(
    //       milliseconds: _controller.value.position.inMilliseconds.round());
    //   setState(() {
    //     duration = [duration.inMinutes, duration.inSeconds]
    //         .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
    //         .join(':') as Duration;
    //   });
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        title: 'Upload Video',
        context: context,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WedfluencerDividers.transparentDivider(),
            InkWell(
              onTap: () {
                WedfluencerBottomSheets.generalBottomSheet(
                  context: context,
                  child: Column(
                    children: [
                      WedfluencerButtons.transparentButton(
                        text: 'Choose from gallery',
                        iconData: Icons.photo_library_outlined,
                        func: () {
                          getImage(src: ImageSource.gallery);
                        },
                      ),
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerButtons.transparentButton(
                        text: 'Record a video',
                        iconData: Icons.camera_alt_outlined,
                        func: () {
                          getImage(src: ImageSource.camera);
                        },
                      ),
                      WedfluencerDividers.transparentDivider(),
                    ],
                  ),
                  height: ScreenConfig.screenSizeHeight * 0.4,
                  heading: 'Select one',
                );
              },
              child: isImagePicked
                  ? ProfileSingleVideo(
                      url: imageFile.path,
                      showThumbnail: false,
                      file: imageFile,
                      isLocal: true,
                      thumbnailUrl: '',
                    )
                  // ? VideoPlayer(_controller)
                  : Icon(
                      Icons.upload,
                      size: 80,
                      color: ScreenConfig.theme.colorScheme.primary,
                    ),
            ),
            // aspectRatio != null
            //     ? VideoProgressIndicator(
            //         _controller,
            //         allowScrubbing: true,
            //         colors: VideoProgressColors(
            //           playedColor: ScreenConfig.theme.primaryColor,
            //           backgroundColor: Colors.black,
            //           bufferedColor: Colors.grey,
            //         ),
            //       )
            //     : const SizedBox(),
            WedfluencerDividers.transparentDividerForHeadings(),
            // aspectRatio != null
            //     ? WedfluencerButtons.fullWidthButton(
            //         text: _controller.value.isPlaying ? 'Pause' : 'Play',
            //         textColor: Colors.white,
            //         buttonColor: ScreenConfig.theme.colorScheme.primary,
            //         hasIcon: false,
            //         func: () {
            //           _controller.value.isPlaying
            //               ? _controller.pause()
            //               : _controller.play();
            //           setState(() {});
            //         },
            //       )
            //     : const SizedBox(),
            WedfluencerDividers.transparentDividerForHeadings(),
            Center(
              child: BlocConsumer<CreateProposalBloc, CreateProposalState>(
                listener: (context, state) {
                  if (state is CreateProposalVideoUploaded) {
                    List<String> categoryIds = [];
                    for (var element in state.vendorCategories) {
                      categoryIds.add(element.value);
                    }
                    if (DI.i<AuthRepository>().isUserLogin) {
                      BlocProvider.of<CreateProposalBloc>(context)
                          .add(UploadCreateProposalDetails(
                        title: state.title,
                        videoId: state.videoId,
                        eventId: state.eventId,
                        categoryIds: categoryIds,
                        accessToken: DI.i<AuthRepository>().accessToken,
                        file: XFile(imageFile.path),
                        fileName: imageFile.path.split('/').last,
                        accountName: state.azureAccountName,
                        referralCode: state.referralCode,
                      ));
                    }
                  } else if (state is CreateProposalDetailsUploaded) {
                    if (DI.i<AuthRepository>().isUserLogin) {
                      BlocProvider.of<UserProposalsBloc>(context)
                          .add(GetUserProposals(
                        accessToken: DI.i<AuthRepository>().accessToken,
                        isMe: true,
                        proposalVideos: [],
                        skip: '0',
                      ));
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      WedfluencerSnackBar.showSnackBar(
                        'Video uploaded successfully',
                        color: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is CreateProposalLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CreateProposalDetailsProvided) {
                    return WedfluencerButtons.fullWidthButton(
                      text: 'Submit',
                      textColor: Colors.white,
                      buttonColor: ScreenConfig.theme.colorScheme.primary,
                      hasIcon: false,
                      func: () {
                        BlocProvider.of<CreateProposalBloc>(context)
                            .add(UploadCreateProposalVideo(
                          title: state.title,
                          file: imageFile,
                          folder: 'folder',
                          description: state.title,
                          isInWeddingShow: state.isInWeddingShow,
                          referralCode: state.referralCode,
                          weddingShowName: state.weddingShowName,
                          weddingShowDate: state.weddingShowDate,
                          weddingLocation: state.weddingLocation,
                          vendorCategories: state.vendorCategories,
                          eventId: state.eventId,
                        ));
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
