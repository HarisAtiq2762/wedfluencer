import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  static final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget displaySideButton({required IconData icon, required String text}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            Text(
              text,
              style: ScreenConfig.theme.textTheme.labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        );

    Widget displayProfileImage() => Badge(
          backgroundColor: ScreenConfig.theme.primaryColor,
          label: const Icon(Icons.add, color: Colors.white, size: 16),
          alignment: Alignment.bottomLeft,
          offset: const Offset(11, 16),
          largeSize: 24,
          child: const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/pic1.jpeg'),
            ),
          ),
        );

    Widget displaySearchBox() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: WedfluencerTextFields.iconTextField(
            controller: search,
            hint: 'Find Friends',
            iconData: Icons.search,
            showSuffix: true,
            suffixIcon: Icons.qr_code_scanner_outlined,
          ),
        );
    Widget displayTextContent() => SizedBox(
          width: ScreenConfig.screenSizeWidth * 0.7,
          height: ScreenConfig.screenSizeHeight * 0.84,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Haris Atiq',
                    style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  WedfluencerDividers.transparentDivider(),
                  Text(
                    'Lorem ipsum dior lorem ipsum dior lorem ipsum dior lorem ipsum dior',
                    style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  WedfluencerDividers.transparentDivider(),
                  Text(
                    '#fyp #married',
                    style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    Widget displaySideBar() => Container(
          width: ScreenConfig.screenSizeWidth * 0.94,
          height: ScreenConfig.screenSizeHeight * 0.8,
          padding: EdgeInsets.only(left: ScreenConfig.screenSizeWidth * 0.82),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              displayProfileImage(),
              WedfluencerDividers.transparentDividerForHeadings(),
              displaySideButton(icon: Icons.favorite, text: '250.5K'),
              WedfluencerDividers.transparentDivider(),
              displaySideButton(icon: Icons.comment, text: '100K'),
              WedfluencerDividers.transparentDivider(),
              displaySideButton(icon: Icons.bookmark, text: '89K'),
              WedfluencerDividers.transparentDivider(),
              displaySideButton(icon: Icons.share, text: '132K'),
            ],
          ),
        );
    Widget displayBody() => Stack(
          children: [
            displaySearchBox(),
            displaySideBar(),
            displayTextContent()
          ],
        );
    return SafeArea(
      child: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/pic1.jpeg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: displayBody(),
        ),
      ),
    );
  }
}
