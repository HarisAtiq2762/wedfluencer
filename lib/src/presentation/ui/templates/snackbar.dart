import 'package:flutter/material.dart';

class WedfluencerSnackBar {
  static SnackBar showSnackBar(String text) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(milliseconds: 5000),
      behavior: SnackBarBehavior.floating,
    );
  }
}
