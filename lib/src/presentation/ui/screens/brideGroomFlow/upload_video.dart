import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
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

  bool isImagePicked = false;
  late VideoPlayerController _controller;
  void getImage({required ImageSource src}) async {
    imageFile = await WedfluencerHelper.getVideo(src: src);
    setState(() {
      isImagePicked = true;
    });
    _controller = VideoPlayerController.file(imageFile)
      ..initialize().then((value) {
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.play();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        title: 'Upload Video',
        context: context,
        showBackButton: true,
      ),
      body: Column(
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
            child: Center(
              child: Container(
                width: ScreenConfig.screenSizeWidth * 0.8,
                height: ScreenConfig.screenSizeHeight * 0.24,
                decoration: ShapeDecoration(
                  color:
                      ScreenConfig.theme.colorScheme.secondary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: isImagePicked
                    ? CircleAvatar(
                        child: VideoPlayer(_controller),
                      )
                    : Icon(
                        Icons.upload,
                        size: 80,
                        color: ScreenConfig.theme.colorScheme.primary,
                      ),
              ),
            ),
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          WedfluencerDividers.transparentDivider(),
          Center(
            child: WedfluencerButtons.fullWidthButton(
              text: 'Submit',
              textColor: Colors.white,
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
              func: () {
                Navigator.pop(context);
                // Navigator.of(context).push(
                //   WedfluencerHelper.createRoute(
                //     page: const HomeScreen(),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
