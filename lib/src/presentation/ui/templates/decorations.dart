import 'package:flutter/material.dart';
import 'dart:io';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import 'buttons.dart';

class WedfluencerDecorations {
  static BoxDecoration scaffoldDecoration({Color color = Colors.white}) =>
      BoxDecoration(color: color);

  static ShapeDecoration shapeDecoration() => const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
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
          color: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                left: ScreenConfig.screenSizeWidth * 0.24,
                top: ScreenConfig.screenSizeHeight * 0.04,
                child: Image.asset(
                  'assets/images/(O).png',
                  height: Platform.isAndroid
                      ? ScreenConfig.screenSizeHeight * 0.3
                      : ScreenConfig.screenSizeHeight * 0.3,
                ),
              ),
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
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Platform.isAndroid
                      ? ScreenConfig.screenSizeHeight * 0.88
                      : ScreenConfig.screenSizeHeight * 0.88,
                  width: ScreenConfig.screenSizeWidth,
                  decoration: shapeDecoration(),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Opacity(
                          opacity: 0.15,
                          child: Container(
                            width: 120,
                            height: 160,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Theme.of(context).primaryColor,
                              //     blurRadius: 40,
                              //   )
                              // ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                bottomLeft: Radius.circular(80),
                                bottomRight: Radius.circular(80),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Opacity(
                          opacity: 0.15,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFC7410),
                                  blurRadius: 80,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                bottomLeft: Radius.circular(80),
                                bottomRight: Radius.circular(80),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
