import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/profile_screen_drawer.dart';

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
   
      endDrawer: const ProfileDrawer(),  
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              
              SliverAppBar(
             
                pinned: true,
                automaticallyImplyLeading: false,
                forceElevated: innerBoxIsScrolled,
              expandedHeight: 50,collapsedHeight: 56,
              
                bottom: TabBar(controller: _controller, tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library_outlined),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Photos'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.videocam_outlined),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Videos'),
                      ],
                    ),
                  )
                ]),
              )
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              const ProfilePhotoListingWidget(),
              const ProfilePhotoListingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
