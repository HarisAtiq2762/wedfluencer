import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerBottomSheets {
  static void generalBottomSheet({
    required BuildContext context,
    required Widget child,
    required double height,
    String? heading,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                ),
              ),
              height: height,
              width: ScreenConfig.screenSizeWidth,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffCDCFD0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  SizedBox(height: heading != null ? 15 : 0),
                  heading != null
                      ? Text(
                          heading,
                          style: ScreenConfig.theme.textTheme.headlineSmall
                              ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
                  child
                ],
              ));
        });
  }
}
