import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WedfluencerHelper {
  static Future<File> getImage({required ImageSource src}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: src,
      maxWidth: 1800,
      maxHeight: 1800,
    );
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
}
