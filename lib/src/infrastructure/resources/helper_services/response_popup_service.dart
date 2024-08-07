import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/resources/helper_services/dialog_box_service.dart';

import '../../../presentation/ui/config/helper.dart';
import '../../../presentation/ui/screens/brideGroomFlow/home.dart';
import '../../dependency_injection.dart';
import '../../navigation_service.dart';

class ResponsePopUpService {
  ResponsePopUpService._();

  static void showVerificationSuccessfullPopUp({
    String? heading,
    String? message,
    String? buttonText,
    VoidCallback? buttonFunction,
  }) {
    BuildContext context = DI.i<NavigationService>().getContext();
    DialogBoxService().wedfluencerDialogBoxWithWidgets(
      context: context,
      heading: heading ?? "Process Successful",
      iconData: Icons.check,
      text: message,
      button1: buttonFunction ??
          () {
            Navigator.of(context).pushAndRemoveUntil(
              WedfluencerHelper.createRoute(page: const HomeScreen()),
              (route) => false,
            );
          },
      button1Text: buttonText ?? "Continue to home",
    );
  }

  static void showVerificationFailedPopUp({
    String? heading,
    String? message,
    String? buttonText,
    VoidCallback? buttonFunction,
  }) {
    BuildContext context = DI.i<NavigationService>().getContext();
    DialogBoxService().wedfluencerDialogBoxWithWidgets(
      context: context,
      heading: heading ?? "Process Failed",
      iconData: Icons.error_outline,
      text: message,
      button1: buttonFunction ??
          () {
            Navigator.pop(
              context,
            );
          },
      button1Text: buttonText ?? "Go Back",
    );
  }
}
