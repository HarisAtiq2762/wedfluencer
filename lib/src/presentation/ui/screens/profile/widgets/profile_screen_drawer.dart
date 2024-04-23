import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/screens/account_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/screens/setting_screen.dart';

import '../screens/edit_profile_screen.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            DrawerTile(
              icon: Icons.portrait_rounded,
              title: 'Profile',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EditProfileScreen();
                }));
              },
            ),
            DrawerTile(
              icon: Icons.account_box,
              title: 'Account',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AccountsScreen();
                }));
              },
            ),
            DrawerTile(
              icon: Icons.settings,
              title: 'Setting',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SettingScreen();
                }));
              },
            ),
            DrawerTile(
              icon: Icons.link,
              title: 'Interest',
              onTap: () {},
            ),
            DrawerTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              color: Colors.redAccent,
              onTap: () {},
            ),
            DrawerTile(
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.redAccent,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
      ),
      onTap: onTap,
    );
  }
}
