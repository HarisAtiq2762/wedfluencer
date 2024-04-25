import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

class ProfileScreenTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;

  const ProfileScreenTabBarDelegate({Key? key, required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: 0.06.sh,
      child: TabBar(controller: controller, tabs: const [
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
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 0.06.sh;

  @override
  // TODO: implement minExtent
  double get minExtent => 0.06.sh;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
