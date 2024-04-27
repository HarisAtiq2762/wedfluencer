import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/templates/profile_screen_widget/profile_image_widget.dart';

class ProfileScreenHeaderDelegate extends SliverPersistentHeaderDelegate {
  const ProfileScreenHeaderDelegate({
    Key? key,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: 0.12.sh,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImageWidget(
              radius: 80,
              imageUrl:
                  'https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg'),
          StatsWidget(
            title: 'Posts',
            count: 100,
          ),
          StatsWidget(
            title: 'Following',
            count: 100,
          ),
          StatsWidget(
            title: 'Followers',
            count: 100,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 0.12.sh;

  @override
  // TODO: implement minExtent
  double get minExtent => 0.12.sh;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

class StatsWidget extends StatelessWidget {
  final String title;
  final int count;

  const StatsWidget({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            style: ScreenConfig.theme.textTheme.labelLarge?.copyWith(
              color: const Color(0xFF121212),
              fontSize: 14,
              letterSpacing: 0.1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            count.toString(),
            maxLines: 1,
            style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF121212),
              fontSize: 12,
              letterSpacing: 0.1,
            ),
          )
        ],
      ),
    );
  }
}
