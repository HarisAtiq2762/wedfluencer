import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';
import 'package:wedfluencer/src/models/producer_event.dart' as pe;
import 'package:wedfluencer/src/models/producer_payment.dart'
    as producer_payment;
import 'package:wedfluencer/src/models/proposal_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/video_player_widget.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../config/dateFormatter.dart';
import 'dialogs.dart';

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
      Material(
        child: InkWell(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(video.title,
                        style: ScreenConfig.theme.textTheme.bodyLarge),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: video.status == 'Published'
                            ? Colors.green.shade50
                            : video.status == 'Failed'
                                ? Colors.red.shade50
                                : video.status == 'Processing'
                                    ? Colors.amber.shade50
                                    : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        video.status,
                        style: ScreenConfig.theme.textTheme.labelSmall
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WedfluencerButtons.smallButton(
                      text: ' View Message',
                      height: 42,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      width: ScreenConfig.screenSizeWidth * 0.28,
                      textColor: Colors.white,
                      func: () {
                        DI
                            .i<NavigationService>()
                            .showCustomDialog(ConfirmationDialog(
                              showCancelButton: false,
                              title: 'Coming Soon',
                              bodyText:
                                  'This feature is in development process and will come soon',
                              filledButtonText: 'Okay',
                              onConfirmation: () {},
                            ));
                      },
                      buttonColor: ScreenConfig.theme.colorScheme.primary,
                      hasIcon: false,
                      iconData: Icons.open_in_new,
                    ),
                    displayCardSubtitle(
                        text: ' ${video.chatRoom.length}',
                        icon: Icons.message_outlined),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  static Future initializeVideoPlayerFuture(
      {required VideoPlayerController controller}) async {
    await controller.initialize();
  }

  static Widget leadCard({
    required void Function()? onTap,
    required ProposalVideo proposalVideo,
  }) =>
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VideoPlayerWidget(video: proposalVideo),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
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

  static Widget paymentCard(
          {required void Function()? onTap,
          required producer_payment.ProducerPayment payment}) =>
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.attach_money_outlined,
                    color: ScreenConfig.theme.primaryColor,
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ScreenConfig.screenSizeWidth * 0.6,
                        child: Text(payment.title,
                            overflow: TextOverflow.ellipsis,
                            style: ScreenConfig.theme.textTheme.bodyLarge),
                      ),
                      Text(
                        'Referral Code ${payment.referralCode}',
                        style: ScreenConfig.theme.textTheme.labelSmall
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '+${payment.totalPaymentsSum.round()}\$',
                    style: ScreenConfig.theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              // Text(
              //   payment.proposalVideosPaymentCount.toString(),
              //   style: ScreenConfig.theme.textTheme.labelSmall
              //       ?.copyWith(fontWeight: FontWeight.normal),
              // ),
              // Text(
              //   payment.proposalVideosCount.toString(),
              //   style: ScreenConfig.theme.textTheme.labelSmall
              //       ?.copyWith(fontWeight: FontWeight.normal),
              // ),
            ],
          ),
        ),
      );
}
