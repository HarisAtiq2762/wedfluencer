import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/resources/helper_services/bottom_bar_service.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class ProducerHomeScreen extends StatefulWidget {
  const ProducerHomeScreen({super.key});

  @override
  State<ProducerHomeScreen> createState() => _ProducerHomeScreenState();
}

class _ProducerHomeScreenState extends State<ProducerHomeScreen> {
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
          BottomBarService.producerBottomBarScreens[
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
                    Icons.event_outlined,
                    color: inactiveColor,
                  ),
                  activeItem: Icon(
                    Icons.event,
                    color: ScreenConfig.theme.colorScheme.primary,
                  ),
                  itemLabel: 'Events',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.attach_money,
                    color: inactiveColor,
                  ),
                  activeItem: Icon(
                    Icons.attach_money_outlined,
                    color: ScreenConfig.theme.colorScheme.primary,
                  ),
                  itemLabel: 'Payments',
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
          //       PatientProducerHomeScreen.notchBottomBarController,
          // ),
        ],
      ),
    );
  }
}
