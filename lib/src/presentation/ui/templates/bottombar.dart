import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerBottomBars {
  static Widget generalBottomBar(
          {required bool isDoctor,
          required NotchBottomBarController notchBottomBarController,
          Color inactiveColor = Colors.black}) =>
      AnimatedNotchBottomBar(
        notchBottomBarController: notchBottomBarController,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home,
              color: inactiveColor,
            ),
            activeItem: Icon(
              Icons.home_outlined,
              color: ScreenConfig.theme.colorScheme.primary,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.medical_services,
              color: inactiveColor,
            ),
            activeItem: Icon(
              Icons.medical_services_outlined,
              color: ScreenConfig.theme.colorScheme.primary,
            ),
            itemLabel: isDoctor ? 'Patients' : 'Doctors',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.qr_code_scanner,
              color: inactiveColor,
            ),
            activeItem: Icon(
              Icons.qr_code_scanner_outlined,
              color: ScreenConfig.theme.colorScheme.primary,
            ),
            itemLabel: 'Scan',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person_2,
              color: inactiveColor,
            ),
            activeItem: Icon(
              Icons.person_2_outlined,
              color: ScreenConfig.theme.colorScheme.primary,
            ),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (int value) {
          // setState(() {});
        },
        kIconSize: 20,
        kBottomRadius: 20,
      );
}
