import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/feed_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/profile_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/vendorFlow/vendor_leads.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  final notchBottomBarController = NotchBottomBarController();
  final inactiveColor = Colors.black;

  List<Widget> screens = [
    const FeedScreen(),
    const VendorLeadsScreen(),
    Container(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          screens[notchBottomBarController.index],

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
                itemLabel: 'Explore',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.attach_money_outlined,
                  color: inactiveColor,
                ),
                activeItem: Icon(
                  Icons.attach_money,
                  color: ScreenConfig.theme.colorScheme.primary,
                ),
                itemLabel: 'Leads',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.chat,
                  color: inactiveColor,
                ),
                activeItem: Icon(
                  Icons.chat_outlined,
                  color: ScreenConfig.theme.colorScheme.primary,
                ),
                itemLabel: 'Chat',
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
                itemLabel: 'Payments',
              ),
            ],
            onTap: (int value) {
              setState(() {
                notchBottomBarController.index = value;
              });
            },
            kIconSize: 20,
            kBottomRadius: 20,
          ),
          // KhairyatBottomBars.generalBottomBar(
          //   isDoctor: false,
          //   notchBottomBarController:
          //       PatientVendorHomeScreen.notchBottomBarController,
          // ),
        ],
      ),
    );
  }
}
