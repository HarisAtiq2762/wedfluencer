import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../presentation/ui/screens/brideGroomFlow/feed_screen.dart';
import '../../../presentation/ui/screens/brideGroomFlow/proposals.dart';
import '../../../presentation/ui/screens/chat/chat_screen.dart';
import '../../../presentation/ui/screens/chat/vendor_chat_screen.dart';
import '../../../presentation/ui/screens/producerFlow/events.dart';
import '../../../presentation/ui/screens/producerFlow/payments.dart';
import '../../../presentation/ui/screens/profile/profile_screen.dart';
import '../../../presentation/ui/screens/vendorFlow/vendor_leads.dart';
import '../../dependency_injection.dart';
import '../../domain/authentication/auth_repository.dart';
import '../../domain/authentication/models/user_model.dart';

class BottomBarService {
  BottomBarService._();

  static NotchBottomBarController notchBottomBarController =
      NotchBottomBarController();

  static VoidCallback homeSetState = () {};
  static void init(VoidCallback setState) {
    notchBottomBarController = NotchBottomBarController();
    homeSetState = setState;
  }

  static List<Widget> homeBottomBarScreens = [
    const FeedScreen(),
    const ProposalsScreen(),
    const ChatHomePage(),
    const ProfileScreen(),
  ];

  static int homeProfileScreenIndex = 3;

  static List<Widget> vendorBottomBarScreens = [
    const FeedScreen(),
    const VendorLeadsScreen(),
    const VendorChatHomePage(),
    const ProfileScreen()
  ];

  static int vendorProfileScreenIndex = 3;

  static List<Widget> producerBottomBarScreens = [
    const FeedScreen(),
    const WeddingProducerEventsScreen(),
    DI.i<AuthRepository>().user!.role == UserRole.weddingProducer
        ? const PaymentScreen()
        : const ChatHomePage(),
    const ProfileScreen(),
  ];

  static int producerProfileScreenIndex = 3;

  static void setProfileNavigation(
    BuildContext context,
  ) {
    final UserModel? loggedInUser = DI.i<AuthRepository>().user;

    if (loggedInUser != null) {
      if (UserRole.getRoleFromString(loggedInUser.role.name) ==
          UserRole.weddingProducer) {
        notchBottomBarController.index = producerProfileScreenIndex;
      } else if (UserRole.getRoleFromString(loggedInUser.role.name) ==
          UserRole.vendor) {
        notchBottomBarController.index = vendorProfileScreenIndex;
      } else if (UserRole.getRoleFromString(loggedInUser.role.name) ==
          UserRole.weddingPlanner) {
        notchBottomBarController.index = homeProfileScreenIndex;
      } else {
        notchBottomBarController.index = homeProfileScreenIndex;
      }
      homeSetState();
    }
  }
}
