import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import 'buttons.dart';

class WedfluencerDecorations {
  static BoxDecoration scaffoldDecoration({Color color = Colors.white}) =>
      BoxDecoration(
          gradient: LinearGradient(colors: [const Color(0xFFFFC599), color]));

  static ShapeDecoration shapeDecoration() => const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
        ),
      );

  static Widget backButton({
    bool showTabBar = false,
    Widget? tabBar,
    required BuildContext context,
  }) =>
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              !showTabBar
                  ? WedfluencerButtons.backButton(func: () {
                      Navigator.pop(context);
                    })
                  : const SizedBox(),
              showTabBar ? tabBar! : const SizedBox(),
            ],
          ),
        ),
      );

  static Widget mainContainer(
          {required BuildContext context,
          required List<Widget> children,
          bool showHeading = true,
          bool showTabBar = false,
          Widget? tabBar,
          String? heading}) =>
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: WedfluencerDecorations.scaffoldDecoration(
          color: ScreenConfig.theme.primaryColor,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              WedfluencerDecorations.backButton(
                  context: context, tabBar: tabBar, showTabBar: showTabBar),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: ScreenConfig.screenSizeHeight * 0.88,
                  width: ScreenConfig.screenSizeWidth,
                  decoration: shapeDecoration(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: showHeading
                            ? ScreenConfig.screenSizeHeight * 0.04
                            : 0,
                      ),
                      child: Column(
                        children: [
                          showHeading
                              ? SizedBox(
                                  width: ScreenConfig.screenSizeWidth * 0.8,
                                  child: Text(
                                    heading!,
                                    style: ScreenConfig
                                        .theme.textTheme.displaySmall
                                        ?.copyWith(
                                      color: const Color(0xFF121212),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: showHeading
                                ? ScreenConfig.screenSizeHeight * 0.04
                                : ScreenConfig.screenSizeHeight * 0.02,
                          ),
                          for (var widget in children)
                            SingleChildScrollView(
                              child: Center(child: widget),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ScreenConfig.theme.primaryColor,
                              blurRadius: 0,
                              spreadRadius: 4,
                            ),
                          ]),
                      child: Image.asset(
                        'assets/logos/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
