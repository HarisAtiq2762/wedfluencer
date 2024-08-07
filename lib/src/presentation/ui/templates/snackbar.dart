import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerSnackBar {
  static SnackBar showSnackBar(String text, {Color? color}) {
    return SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(color: Colors.white),
        textAlign: TextAlign.start,
      ),
      duration: const Duration(milliseconds: 5000),
      behavior: SnackBarBehavior.fixed,
    );
  }
}
