import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dialogs.dart';
import '../../account_screen.dart';
import '../../edit_profile/edit_profile_screen.dart';
import '../../setting_screen.dart';
import '../../interest_screen.dart';

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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const InterestScreen();
                }));
              },
            ),
            DrawerTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              color: Colors.redAccent,
              onTap: () {
                showDialog(context: context, builder: (context){return ConfirmationDialog(
                  title: 'Delete Account',
                  bodyText: 'Are you sure you want to delete this account?',
                  filledButtonText:'Delete' ,
                  onConfirmation: (){},
                );});
              },
            ),
            DrawerTile(
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.redAccent,
              onTap: () {
                showDialog(context: context, builder: (context){return ConfirmationDialog(
                  title: 'Logout',
                  bodyText: 'Are you sure you want to logout from app?',
                  filledButtonText: 'Logout',
                  onConfirmation: (){},
                );});
              },
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
