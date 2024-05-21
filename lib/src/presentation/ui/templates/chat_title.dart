import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import 'headings.dart';

class WedfluencerChatTitle {
  static Widget chatTitle({required String title, required String subtitle}) =>
      Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/logos/logo.png'),
            backgroundColor: Colors.white,
            radius: 26,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerHeadings.generalHeading(heading: title),
              Text(subtitle, style: ScreenConfig.theme.textTheme.bodyMedium),
            ],
          ),
          const Spacer(),
          Text(
            'May/3/2024',
            style: ScreenConfig.theme.textTheme.bodySmall
                ?.copyWith(color: ScreenConfig.theme.primaryColor),
          ),
        ],
      );
}
