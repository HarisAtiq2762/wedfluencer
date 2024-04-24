import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedfluencer/src/app.dart';

class HelperFunction{
  static Future<File?> pickProfileImage(
      {required ImageSource source, String? title}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final croppedImage = await ImageCropper().cropImage(
            sourcePath: image.path,
            compressQuality: 60,
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: title,
                  toolbarColor: themeColor,
                  hideBottomControls: true),
              IOSUiSettings(
                  title: title,
                  rotateButtonsHidden: true,
                  hidesNavigationBar: true),
            ]);
        if (croppedImage != null) {
          return File(croppedImage.path);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      // DI.i<NavigationService>().showSnackBar(message: 'Something went wrong');
      return null;
    }
  }
}