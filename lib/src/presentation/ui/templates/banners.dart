import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class WedfluencerBanners {
  static MaterialBanner generalBanner(
          {required ContentType type,
          required String title,
          required String msg}) =>
      MaterialBanner(
        dividerColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        forceActionsBelow: true,
        content: AwesomeSnackbarContent(
          title: title,
          message: msg,
          contentType: type,
          inMaterialBanner: true,
        ),
        actions: const [SizedBox.shrink()],
      );
}
