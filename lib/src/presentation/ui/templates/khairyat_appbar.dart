import 'package:flutter/material.dart';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import 'buttons.dart';

class WedfluencerAppbar {
  static PreferredSizeWidget generalAppbar(
          {required String title,
          bool showBackButton = true,
          required BuildContext context,
          bool hasActions = false}) =>
      AppBar(
        actions: [
          hasActions
              ? IconButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   WedfluencerHelper.createRoute(
                    //     page: const NotificationScreen(),
                    //   ),
                    // );
                  },
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
        ],
        leading: showBackButton
            ? WedfluencerButtons.backButton(func: () {
                Navigator.pop(context);
              })
            : const SizedBox(),
        backgroundColor: ScreenConfig.theme.primaryColor,
        title: Text(
          title,
          style: ScreenConfig.theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      );
}
