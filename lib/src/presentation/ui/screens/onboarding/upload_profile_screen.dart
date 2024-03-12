import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({super.key});

  static const routeName = '/upload-profile-screen';

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
  late File imageFile;
  bool isImagePicked = false;

  void getImage({required ImageSource src}) async {
    imageFile = await WedfluencerHelper.getImage(src: src);
    setState(() {
      isImagePicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Upload your profile picture !',
      children: [
        Container(
          width: ScreenConfig.screenSizeWidth * 0.6,
          height: ScreenConfig.screenSizeHeight * 0.24,
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: isImagePicked
              ? CircleAvatar(backgroundImage: FileImage(imageFile))
              : Image.asset('assets/images/Background.png'),
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
        WedfluencerButtons.transparentButton(
          text: 'Choose on gallery',
          iconData: Icons.photo_library_outlined,
          func: () {
            getImage(src: ImageSource.gallery);
          },
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
        WedfluencerButtons.transparentButton(
          text: 'Take a picture',
          iconData: Icons.camera_alt_outlined,
          func: () {
            getImage(src: ImageSource.camera);
          },
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
        WedfluencerButtons.fullWidthButton(
          text: 'Continue',
          textColor: Colors.white,
          func: () {
            // Navigator.of(context).push(
            //   WedfluencerHelper.createRoute(
            //     page: const SelectWeightScreen(),
            //   ),
            // );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
      ],
    );
  }
}
