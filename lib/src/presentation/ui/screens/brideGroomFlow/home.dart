import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/feed_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/proposals.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notchBottomBarController = NotchBottomBarController();
  final inactiveColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          notchBottomBarController.index == 0
              ? const FeedScreen()
              : notchBottomBarController.index == 1
                  ? const ProposalsScreen()
                  : notchBottomBarController.index == 2
                      ? Container()
                      : Container(),
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
                notchBottomBarController.index = value;
              });
            },
            kIconSize: 20,
            kBottomRadius: 20,
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
