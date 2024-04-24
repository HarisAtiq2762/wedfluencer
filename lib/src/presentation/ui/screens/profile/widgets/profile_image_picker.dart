import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

import '../../../../../infrastructure/constants/image_constant.dart';
import '../../../templates/bottomsheets.dart';
import '../../../templates/custom_image_widget.dart';
import 'image_selection_bottomsheet.dart';

class ProfileImagePicker extends StatefulWidget {
  final String? imageUrl;
  final Function(File) onChnage;
  const ProfileImagePicker({super.key,required this.imageUrl,required this.onChnage});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomImageWidget(
            height: 100,
            width: 100,
            radius: 1000,
             image: pickedImage,
            imageUrl:widget.imageUrl
                , placeHolder: ImageConstant.profileImagePlaceHolder,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
              onPressed: () async {
                final pickedImage = await WedfluencerBottomSheets.generalBottomSheet(context: context, child: const ImageSourceSelectionBottomSheet(), height: 0.24.sh);
             
             if(pickedImage!=null){
              setState(() {
                this.pickedImage = pickedImage;
              });
              widget.onChnage(pickedImage);
             }
              },
              style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                      side: const BorderSide(
                        color: Colors.white,
                      ))),
              icon: const Icon(Icons.edit, color: Colors.black)),
        )
      ],
    );
  }
}
