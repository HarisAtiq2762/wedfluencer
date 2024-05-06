import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedfluencer/src/presentation/bloc/image/image_bloc.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../config/helper.dart';
import 'bottomsheets.dart';
import 'buttons.dart';
import 'dividers.dart';

class UploadImageWidget extends StatefulWidget {
  const UploadImageWidget({super.key});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  File? imageFile;

  void getImage({required ImageSource src}) async {
    imageFile = await WedfluencerHelper.pickProfileImage(source: src);
    setState(() {});
    BlocProvider.of<ImageBloc>(context).add(GetImages(file: imageFile));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                text: 'Take a picture',
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
            color: ScreenConfig.theme.colorScheme.secondary.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: imageFile != null
              ? Image(image: FileImage(imageFile!))
              : Icon(
                  Icons.upload,
                  size: 80,
                  color: ScreenConfig.theme.colorScheme.primary,
                ),
        ),
      ),
    );
  }
}
