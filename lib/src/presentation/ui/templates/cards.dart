import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerCards {
  static Widget displayCardSubtitle(
          {required IconData icon, required String text}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: ScreenConfig.theme.primaryColor,
          ),
          Text(
            text,
            style: ScreenConfig.theme.textTheme.labelSmall
                ?.copyWith(fontWeight: FontWeight.normal),
          )
        ],
      );
  static Widget eventCard({required void Function()? onTap}) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logos/logo.png',
                  fit: BoxFit.cover,
                  width: ScreenConfig.screenSizeWidth * 0.2,
                ),
              ),
              const Spacer(),
              Text(
                'Title',
                style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              displayCardSubtitle(
                  text: ' Tue, Feb 20, 2024', icon: Icons.event_outlined),
              const SizedBox(height: 6),
              displayCardSubtitle(
                  text: ' 06 PM - 06 PM', icon: Icons.access_time_outlined),
            ],
          ),
        ),
      );

  static Widget leadCard({required void Function()? onTap}) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Image.asset(
                'assets/logos/logo.png',
                fit: BoxFit.cover,
                width: ScreenConfig.screenSizeWidth * 0.2,
              ),
            ),
            const Spacer(),
            WedfluencerButtons.smallButton(
              text: 'View More',
              textColor: Colors.white,
              func: onTap,
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: true,
              iconData: Icons.open_in_new,
            ),
          ],
        ),
      );
}
