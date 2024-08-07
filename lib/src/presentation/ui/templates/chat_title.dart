import 'package:flutter/material.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerChatTitle {
  static Widget chatTitle(
      {required String title,
      required String subtitle,
      required String date,
      required String unread,
      required bool isOnline,
      required String imageUrl}) {
    return Row(
      children: [
        imageUrl != ''
            ? Badge(
                alignment: Alignment.bottomRight,
                smallSize: 10,
                backgroundColor: isOnline ? Colors.green : Colors.red,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.white,
                  radius: 26,
                ),
              )
            : const CircleAvatar(
                backgroundImage: AssetImage('assets/logos/logo.png'),
                backgroundColor: Colors.white,
                radius: 26,
              ),
        const SizedBox(width: 12),
        SizedBox(
          width: ScreenConfig.screenSizeWidth * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  date,
                  style: ScreenConfig.theme.textTheme.labelMedium
                      ?.copyWith(color: ScreenConfig.theme.primaryColor),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: ScreenConfig.theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  unread.toString() == "0"
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 10,
                          child: Center(
                              child: Text(
                            unread,
                            style: ScreenConfig.theme.textTheme.bodySmall
                                ?.copyWith(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                          )),
                        ),
                ],
              ),
              SizedBox(
                  width: ScreenConfig.screenSizeWidth * 0.7,
                  child: Text(subtitle,
                      style: ScreenConfig.theme.textTheme.bodySmall)),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
