import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/models/producer_event.dart' as pe;
import 'package:wedfluencer/src/models/proposal_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../config/dateFormatter.dart';

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
  static Widget eventCard(
          {required void Function()? onTap, required pe.ProducerEvent event}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          height: ScreenConfig.screenSizeHeight * 0.32,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: event.image!
                    .map((e) => Image.network(e.url!, fit: BoxFit.fill))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 3 / 1.2,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
              ),
              const Spacer(),
              Text(
                event.title!,
                style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              displayCardSubtitle(
                  text: ' ${eventDate.format(event.startDate!)}',
                  icon: Icons.event_outlined),
              const SizedBox(height: 6),
              displayCardSubtitle(
                text:
                    ' ${eventHourFormat.format(event.startDate!)} - ${eventHourFormat.format(event.endDate!)}',
                icon: Icons.access_time_outlined,
              ),
            ],
          ),
        ),
      );

  static Widget proposalCard(
          {required void Function()? onTap, required ProposalVideo video}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(video.title!, style: ScreenConfig.theme.textTheme.bodyLarge),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WedfluencerButtons.smallButton(
                    text: ' View Message',
                    height: 38,
                    fontSize: 10,
                    width: ScreenConfig.screenSizeWidth * 0.26,
                    textColor: Colors.white,
                    func: () {},
                    buttonColor: ScreenConfig.theme.colorScheme.primary,
                    hasIcon: false,
                    iconData: Icons.open_in_new,
                  ),
                  displayCardSubtitle(text: ' 1', icon: Icons.message_outlined),
                ],
              ),
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
