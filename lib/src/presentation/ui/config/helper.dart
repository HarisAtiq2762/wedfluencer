import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedfluencer/src/app.dart';

class WedfluencerHelper {
  static Future<File> getVideo({required ImageSource src}) async {
    XFile? pickedFile = await ImagePicker().pickVideo(
      source: src,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 1),
    );
    return File(pickedFile!.path);
  }

  static Future<File> getMedia() async {
    XFile? pickedFile = await ImagePicker().pickMedia();
    return File(pickedFile!.path);
  }

  // static Route createRoute(
  //     {required Widget page, required RouteSettings settings}) {
  //   return PageRouteBuilder(
  //     settings: settings,
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const curve = Curves.ease;
  //       var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
  //       return FadeTransition(
  //         opacity: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  static Route createRoute({required Widget page}) {
    return PageRouteBuilder(
      // settings: RouteSettings(
      //   name: page.routeName,
      // ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.ease;
        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }

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
      return null;
    }
  }

  static Future<List<XFile>> pickMultipleImages({String? title}) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images.isNotEmpty) {
        return images;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
