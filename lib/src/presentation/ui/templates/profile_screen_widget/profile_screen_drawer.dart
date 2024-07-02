import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_event.dart';
import 'package:wedfluencer/src/presentation/ui/screens/events/producer_event.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dialogs.dart';

import '../../../bloc/authentication/auth_bloc.dart';
import '../../screens/account_screen.dart';
import '../../screens/edit_profile/edit_profile_screen.dart';
import '../../screens/interest/interest_screen.dart';
import '../../screens/producerFlow/payments.dart';
import '../../screens/setting_screen.dart';
import '../drawer_tile.dart';

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
              icon: Icons.calendar_month,
              title: 'My Events',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProducerEventsScreen();
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
            DI.i<AuthRepository>().user!.role == UserRole.weddingProducer
                ? DrawerTile(
                    icon: Icons.attach_money_outlined,
                    title: 'Payments',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PaymentScreen();
                      }));
                    },
                  )
                : const SizedBox(),
            DrawerTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              color: Colors.redAccent,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        title: 'Delete Account',
                        bodyText:
                            'Are you sure you want to delete this account?',
                        filledButtonText: 'Delete',
                        onConfirmation: () {},
                      );
                    });
              },
            ),
            DrawerTile(
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.redAccent,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        title: 'Logout',
                        bodyText: 'Are you sure you want to logout from app?',
                        filledButtonText: 'Logout',
                        onConfirmation: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            AuthenticationSignOutEvent(),
                          );
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
