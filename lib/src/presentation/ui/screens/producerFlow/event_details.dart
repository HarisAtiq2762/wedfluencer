import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wedfluencer/src/models/producer_event.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/dateFormatter.dart';
import '../../templates/khairyat_appbar.dart';

class EventDetailsScreen extends StatelessWidget {
  final ProducerEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final screenshotController = ScreenshotController();

    void downloadTicket() async {
      await screenshotController
          .capture(delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath =
              await File('${directory.path}/${event.title}.png').create();
          await imagePath.writeAsBytes(image);
          await Share.shareXFiles([XFile(imagePath.path)]);
        }
      });
    }

    Widget displayTicket() => Screenshot(
          controller: screenshotController,
          child: Center(
            child: Container(
              width: ScreenConfig.screenSizeWidth * 0.9,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 131, 198, 252),
                    Color.fromARGB(255, 216, 158, 226)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title!,
                          style: ScreenConfig.theme.textTheme.bodyLarge),
                      SizedBox(
                        width: ScreenConfig.screenSizeWidth * 0.64,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            event.location!,
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            eventDate.format(event.startDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ' ${eventHourFormat.format(event.startDate!)}',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(event.description!,
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        'Referral code: ${event.referralCode}',
                        style: ScreenConfig.theme.textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'www.wedfluencer.com',
                        style: ScreenConfig.theme.textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: downloadTicket,
                          icon: const Icon(Icons.download)),
                      QrImageView(
                        data: event.referralCode!,
                        version: QrVersions.auto,
                        size: 80.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Event Details',
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(event.title!,
                  style: ScreenConfig.theme.textTheme.bodyLarge),
            ),
            SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    markers: {
                      Marker(
                        markerId: const MarkerId('Wedding Show Location'),
                        position:
                            LatLng(event.latitude ?? 0, event.longitude ?? 0),
                      ),
                    },
                    indoorViewEnabled: true,
                    initialCameraPosition: CameraPosition(
                      bearing: 90,
                      target: LatLng(event.latitude ?? 0, event.longitude ?? 0),
                      tilt: 59.440717697143555,
                      zoom: 15,
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildStyledBox(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WedfluencerDividers.transparentDividerForHeadings(),
                    WedfluencerDividers.transparentDivider(),
                    WedfluencerHeadings.generalHeading(heading: 'About'),
                    const SizedBox(height: 12),
                    Text(
                      event.description!,
                      style: ScreenConfig.theme.textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                    WedfluencerDividers.transparentDividerForHeadings(),
                    WedfluencerHeadings.generalHeading(heading: 'Show Details'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Start Date',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventDate.format(event.startDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Start Time',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventHourFormat.format(event.startDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'End Date',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventDate.format(event.endDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'End Time',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventHourFormat.format(event.endDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Location',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: ScreenConfig.screenSizeWidth * 0.6,
                            child: Text(
                              event.location!,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Location Detail',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: ScreenConfig.screenSizeWidth * 0.6,
                            child: Text(
                              event.locationDetail!,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Referral Code',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: ScreenConfig.screenSizeWidth * 0.6,
                            child: Text(
                              event.referralCode!,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    WedfluencerDividers.transparentDividerForHeadings(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            displayTicket(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledBox(BuildContext context, Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
