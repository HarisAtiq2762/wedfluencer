import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

import '../../../models/person.dart';

class WedfluencerCards {
  static Widget personCard({required Person person}) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    'assets/images/${person.image}',
                    height: ScreenConfig.screenSizeHeight * 0.148,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: ScreenConfig.theme.colorScheme.primary,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person.name,
                      overflow: TextOverflow.ellipsis,
                      style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.50,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/location.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 100,
                          child: Text(
                            '${person.distance} Kilometers away',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xFF828282),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.67,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
