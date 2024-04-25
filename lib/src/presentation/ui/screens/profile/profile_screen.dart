import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/profile_screen_drawer.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../edit_profile/widget/profile_screen_delegate.dart';
import '../edit_profile/widget/profile_tabbar_delegate.dart';
import 'widgets/profile_photo_listing.dart';

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
      body: SafeArea(
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
                        'Syed Ahmed Hamza Imam ',
                        style: ScreenConfig.theme.textTheme.labelLarge
                            ?.copyWith(
                                color: const Color(0xFF121212), fontSize: 16),
                      )),
                      Flexible(
                          child: Text(
                        '@userName',
                        style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF121212),
                        ),
                      )),
                    ],
                  ),
                  pinned: false,
                  automaticallyImplyLeading: false,
                ),const SliverPersistentHeader(delegate: ProfileScreenHeader()),
                SliverPersistentHeader(
                    pinned: true,
                    delegate:
                        ProfileScreenTabBarDelegate(controller: _controller)),
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
      ),
    );
  }
}
