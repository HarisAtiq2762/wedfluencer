import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/resources/helper_services/bottom_bar_service.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final inactiveColor = Colors.black;

  @override
  void initState() {
    super.initState();
    BottomBarService.init(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BottomBarService.homeBottomBarScreens[
              BottomBarService.notchBottomBarController.index],

          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedNotchBottomBar(
              notchBottomBarController:
                  BottomBarService.notchBottomBarController,
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
                    Icons.add,
                    color: inactiveColor,
                  ),
                  activeItem: Icon(
                    Icons.add,
                    color: ScreenConfig.theme.colorScheme.primary,
                  ),
                  itemLabel: 'Proposal',
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
                  itemLabel: 'Profile',
                ),
              ],
              onTap: (int value) {
                setState(() {
                  BottomBarService.notchBottomBarController.index = value;
                });
              },
              kIconSize: 20,
              kBottomRadius: 20,
            ),
          ),
          // KhairyatBottomBars.generalBottomBar(
          //   isDoctor: false,
          //   notchBottomBarController:
          //       PatientHomeScreen.notchBottomBarController,
          // ),
        ],
      ),
    );
  }
}
