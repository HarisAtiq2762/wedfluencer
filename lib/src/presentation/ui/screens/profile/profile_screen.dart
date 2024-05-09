import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_state.dart';
import 'package:wedfluencer/src/presentation/ui/templates/profile_screen_widget/profile_screen_drawer.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/edit_profile_widget/profile_screen_header_delegate.dart';
import '../../templates/edit_profile_widget/profile_tabbar_delegate.dart';
import '../../templates/profile_screen_widget/profile_photo_listing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const ProfileDrawer(),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state);
          if (state.signInLoading == false) {
            return SafeArea(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: Text(
                              DI.i<AuthRepository>().user!.getFullName,
                              style: ScreenConfig.theme.textTheme.labelLarge
                                  ?.copyWith(
                                      color: const Color(0xFF121212),
                                      fontSize: 16),
                            )),
                            Flexible(
                                child: Text(
                              DI.i<AuthRepository>().user!.userName,
                              style: ScreenConfig.theme.textTheme.bodySmall
                                  ?.copyWith(
                                color: const Color(0xFF121212),
                              ),
                            )),
                          ],
                        ),
                        pinned: false,
                        automaticallyImplyLeading: false,
                      ),
                      const SliverPersistentHeader(
                          delegate: ProfileScreenHeaderDelegate()),
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: ProfileScreenTabBarDelegate(
                              controller: _controller)),
                    ];
                  },
                  body: TabBarView(
                    controller: _controller,
                    children: const [
                      ProfilePhotoListingWidget(),
                      ProfilePhotoListingWidget(),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
