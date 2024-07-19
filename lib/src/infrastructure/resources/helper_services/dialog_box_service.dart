import 'package:flutter/material.dart';

import '../../../presentation/ui/templates/buttons.dart';
import '../../constants/colors.dart';
import '../../screen_size_config/screen_size_config.dart';

class DialogBoxService {
  double kDialogBoxBottomPadding = 14;
  double kDialogBoxRadius = 15;
  double kDialogBoxIconBLRPadding = 14;

  Color themeDarkColor = ThemeColors().themeDarkColor;

  Future<VoidCallback?> wedfluencerDialogBoxWithWidgets({
    required BuildContext context,
    String? heading,
    String? text,
    IconData? iconData,
    List<Widget>? widgets,
    String? button1Text,
    VoidCallback? button1,
    bool barrierDismissable = false,
    bool willPopScope = false,
    VoidCallback? thenFunction,
    Color? barrierColor,
    Color? buttonCustomerColor,
  }) {
    return showDialog(
      // barrierColor:
      //     barrierColor ?? ScreenConfig.theme.primaryColor.withOpacity(0.50),
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => willPopScope,
        child: AlertDialog(
          scrollable: true,
          actionsPadding: EdgeInsets.only(
            left: ScreenConfig.screenSizeWidth * 0.1,
            right: ScreenConfig.screenSizeWidth * 0.1,
            bottom: kDialogBoxBottomPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              kDialogBoxRadius,
            ),
          ),
          title: (iconData != null || heading != null)
              ? Column(
                  children: [
                    if (iconData != null)
                      Padding(
                        padding: EdgeInsets.only(
                          left: kDialogBoxIconBLRPadding,
                          right: kDialogBoxIconBLRPadding,
                          bottom: kDialogBoxIconBLRPadding,
                        ),
                        child: Icon(
                          iconData,
                          size: 50,
                          color: themeDarkColor,
                        ),
                      ),
                    if (heading != null)
                      Text(
                        heading,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: themeDarkColor,
                        ),
                      ),
                  ],
                )
              : null,
          content: (text != null || widgets != null)
              ? Column(
                  children: [
                    if (text != null)
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: themeDarkColor,
                        ),
                      ),
                    if (widgets != null)
                      Column(
                        children: widgets,
                      )
                  ],
                )
              : null,
          actionsAlignment: MainAxisAlignment.center,
          actions: (button1Text != null && button1 != null)
              ? [
                  WedfluencerButtons.fullWidthButton(
                    borderRadius: 100,
                    buttonColor: buttonCustomerColor ?? themeDarkColor,
                    func: () {
                      button1();
                    },
                    height: 50,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    text: button1Text,
                    hasIcon: false,
                  )
                ]
              : null,
        ),
      ),
    ).then(
      (value) => thenFunction,
    );
  }
}
