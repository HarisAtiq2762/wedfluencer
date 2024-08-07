import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
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
  final bool multiImage;

  const UploadImageWidget({super.key, required this.multiImage});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  File? imageFile;
  List<XFile> imageFiles = [];

  void getImage({required ImageSource src}) async {
    imageFile = await WedfluencerHelper.pickProfileImage(source: src);
    setState(() {});
    BlocProvider.of<ImageBloc>(context).add(GetImages(file: imageFile));
    Navigator.pop(context);
  }

  void getMultipleImages() async {
    imageFiles = await WedfluencerHelper.pickMultipleImages();
    print(imageFiles);
    setState(() {});
    BlocProvider.of<ImageBloc>(context)
        .add(GetMultipleImages(files: imageFiles));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    imageDisplay() {
      return widget.multiImage
          ? imageFiles.isNotEmpty
              ? CarouselSlider(
                  items:
                      imageFiles.map((e) => Image.file(File(e.path))).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                  ),
                )
              : Icon(
                  Icons.upload,
                  size: 80,
                  color: ScreenConfig.theme.colorScheme.primary,
                )
          : imageFile != null
              ? Image(image: FileImage(imageFile!))
              : Icon(
                  Icons.upload,
                  size: 80,
                  color: ScreenConfig.theme.colorScheme.primary,
                );
    }

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
                  widget.multiImage
                      ? getMultipleImages()
                      : getImage(src: ImageSource.gallery);
                },
              ),
              widget.multiImage
                  ? const SizedBox()
                  : WedfluencerDividers.transparentDivider(),
              widget.multiImage
                  ? const SizedBox()
                  : WedfluencerButtons.transparentButton(
                      text: 'Take a picture',
                      iconData: Icons.camera_alt_outlined,
                      func: () {
                        getImage(src: ImageSource.camera);
                      },
                    ),
              WedfluencerDividers.transparentDivider(),
            ],
          ),
          height: widget.multiImage
              ? ScreenConfig.screenSizeHeight * 0.26
              : ScreenConfig.screenSizeHeight * 0.4,
          heading: widget.multiImage ? 'Select at least one' : 'Select one',
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
            child: imageDisplay()),
      ),
    );
  }
}
